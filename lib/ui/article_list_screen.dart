import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../logic/threading.dart';
import '../state/providers.dart';
import 'article_screen.dart';
import 'compose_screen.dart';
import 'widgets.dart';

class ArticleListScreen extends ConsumerStatefulWidget {
  final Server server;
  final Subscription subscription;
  const ArticleListScreen({
    super.key,
    required this.server,
    required this.subscription,
  });

  @override
  ConsumerState<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends ConsumerState<ArticleListScreen> {
  bool _syncing = false;
  String? _error;

  GroupKey get _key =>
      GroupKey(widget.server.id, widget.subscription.groupName);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  Future<void> _sync() async {
    if (_syncing) return;
    setState(() {
      _syncing = true;
      _error = null;
    });
    try {
      final sub = await ref
              .read(databaseProvider)
              .findSubscription(widget.server.id, widget.subscription.groupName) ??
          widget.subscription;
      await ref.read(repositoryProvider).syncSubscription(sub);
    } catch (e) {
      if (mounted) setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final threads = ref.watch(threadsProvider(_key));
    final flat = flattenThreads(threads);
    final mode = ref.watch(articleListModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subscription.groupName,
            overflow: TextOverflow.ellipsis),
        actions: [
          PopupMenuButton<ArticleListMode>(
            icon: const Icon(Icons.view_list),
            initialValue: mode,
            onSelected: (m) =>
                ref.read(articleListModeProvider.notifier).state = m,
            itemBuilder: (_) => const [
              PopupMenuItem(
                  value: ArticleListMode.threaded, child: Text('Threaded')),
              PopupMenuItem(
                  value: ArticleListMode.flat, child: Text('Flat (newest)')),
              PopupMenuItem(
                  value: ArticleListMode.unreadOnly, child: Text('Unread only')),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'read') {
                ref.read(repositoryProvider).markGroupRead(
                    widget.server.id, widget.subscription.groupName);
              } else if (v == 'refresh') {
                _sync();
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'refresh', child: Text('Refresh')),
              PopupMenuItem(
                  value: 'read', child: Text('Mark all as read')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (_syncing) const LinearProgressIndicator(),
          if (_error != null)
            ErrorBanner(message: _error!, onRetry: _sync),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _sync,
              child: flat.isEmpty
                  ? ListView(
                      children: [
                        const SizedBox(height: 120),
                        Center(
                          child: Text(_syncing
                              ? 'Loading articles…'
                              : 'No articles'),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: flat.length,
                      itemBuilder: (_, i) {
                        final node = flat[i];
                        return _ArticleRow(
                          node: node,
                          threaded: mode == ArticleListMode.threaded,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ArticleScreen(
                                server: widget.server,
                                subscription: widget.subscription,
                                articleId: node.article.id,
                                threadKey: _key,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ComposeScreen(
            server: widget.server,
            newsgroup: widget.subscription.groupName,
          ),
        )),
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class _ArticleRow extends ConsumerWidget {
  final ThreadNode node;
  final bool threaded;
  final VoidCallback onTap;
  const _ArticleRow({
    required this.node,
    required this.threaded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = node.article;
    final unread = !a.isRead;
    final indent = threaded ? (node.depth.clamp(0, 6) * 16.0) : 0.0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12 + indent, 10, 12, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 8),
              child: Icon(
                unread ? Icons.circle : Icons.circle_outlined,
                size: 10,
                color: unread
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.subject.isEmpty ? '(no subject)' : a.subject,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight:
                          unread ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${a.authorName.isEmpty ? a.fromRaw : a.authorName}'
                    '${a.date != null ? '  ·  ${formatRelative(a.date!)}' : ''}'
                    '${threaded && node.children.isNotEmpty ? '  ·  ${node.totalCount - 1} repl${node.totalCount - 1 == 1 ? 'y' : 'ies'}' : ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (a.isStarred)
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 2),
                child: Icon(Icons.star, size: 16, color: Colors.amber),
              ),
          ],
        ),
      ),
    );
  }
}
