import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../state/providers.dart';

class BrowseGroupsScreen extends ConsumerStatefulWidget {
  final Server server;
  const BrowseGroupsScreen({super.key, required this.server});

  @override
  ConsumerState<BrowseGroupsScreen> createState() => _BrowseGroupsScreenState();
}

class _BrowseGroupsScreenState extends ConsumerState<BrowseGroupsScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';
  bool _refreshing = false;
  String? _error;
  int _catalogCount = 0;
  List<GroupCatalogData> _results = const [];
  Set<String> _subscribed = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final db = ref.read(databaseProvider);
    final count = await db.catalogCount(widget.server.id);
    final subs = await db.watchSubscriptions(widget.server.id).first;
    final results = await ref
        .read(repositoryProvider)
        .searchGroups(widget.server.id, _query);
    if (!mounted) return;
    setState(() {
      _catalogCount = count;
      _subscribed = subs.map((s) => s.groupName).toSet();
      _results = results;
    });
    if (count == 0 && !_refreshing) _refreshCatalog();
  }

  Future<void> _refreshCatalog() async {
    setState(() {
      _refreshing = true;
      _error = null;
    });
    try {
      await ref.read(repositoryProvider).refreshCatalog(widget.server.id);
      await _load();
    } catch (e) {
      if (mounted) setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      setState(() => _query = value);
      _load();
    });
  }

  Future<void> _toggle(GroupCatalogData g) async {
    final repo = ref.read(repositoryProvider);
    if (_subscribed.contains(g.groupName)) {
      await repo.unsubscribe(widget.server.id, g.groupName);
      setState(() => _subscribed.remove(g.groupName));
    } else {
      await repo.subscribe(widget.server.id, g);
      setState(() => _subscribed.add(g.groupName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.server.name),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search groups',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Reload group list',
            onPressed: _refreshing ? null : _refreshCatalog,
            icon: const Icon(Icons.sync),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_refreshing) const LinearProgressIndicator(),
          if (_error != null)
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.errorContainer,
              padding: const EdgeInsets.all(12),
              child: Text(_error!),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _catalogCount == 0
                    ? 'No group list downloaded yet'
                    : '$_catalogCount groups cached · showing ${_results.length}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (_, i) {
                final g = _results[i];
                final sub = _subscribed.contains(g.groupName);
                return ListTile(
                  title: Text(g.groupName),
                  subtitle:
                      g.description.isEmpty ? null : Text(g.description),
                  trailing: IconButton(
                    icon: Icon(sub
                        ? Icons.check_circle
                        : Icons.add_circle_outline),
                    color: sub ? Theme.of(context).colorScheme.primary : null,
                    onPressed: () => _toggle(g),
                  ),
                  onTap: () => _toggle(g),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
