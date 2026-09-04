import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../state/providers.dart';
import 'article_list_screen.dart';
import 'browse_groups_screen.dart';
import 'server_edit_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [_SubscriptionsTab(), _ServersTab()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.forum_outlined),
              selectedIcon: Icon(Icons.forum),
              label: 'Groups'),
          NavigationDestination(
              icon: Icon(Icons.dns_outlined),
              selectedIcon: Icon(Icons.dns),
              label: 'Servers'),
        ],
      ),
    );
  }
}

class _SubscriptionsTab extends ConsumerWidget {
  const _SubscriptionsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servers = ref.watch(serversProvider);
    final subs = ref.watch(allSubscriptionsProvider);
    final syncStatus = ref.watch(syncStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Newsgroups'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
        bottom: syncStatus.running
            ? const PreferredSize(
                preferredSize: Size.fromHeight(2),
                child: LinearProgressIndicator(minHeight: 2),
              )
            : null,
      ),
      body: servers.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (serverList) {
          if (serverList.isEmpty) {
            return _EmptyState(
              icon: Icons.dns,
              title: 'No servers yet',
              message: 'Add a news server to get started.',
              actionLabel: 'Add server',
              onAction: () => _openServerEdit(context),
            );
          }
          final subList = subs.valueOrNull ?? const [];
          if (subList.isEmpty) {
            return _EmptyState(
              icon: Icons.forum,
              title: 'No subscriptions',
              message: 'Browse a server to subscribe to groups.',
              actionLabel: 'Browse groups',
              onAction: () => _browse(context, ref, serverList),
            );
          }
          final byServer = groupBy(subList, (Subscription s) => s.serverId);
          return RefreshIndicator(
            onRefresh: () => ref.read(syncServiceProvider).syncAll(),
            child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              for (final server in serverList)
                if (byServer[server.id]?.isNotEmpty ?? false) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Text(server.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                  for (final sub in byServer[server.id]!)
                    _SubscriptionTile(server: server, sub: sub),
                ],
            ],
            ),
          );
        },
      ),
      floatingActionButton: servers.valueOrNull?.isNotEmpty == true
          ? FloatingActionButton.extended(
              onPressed: () => _browse(context, ref, servers.value!),
              icon: const Icon(Icons.add),
              label: const Text('Add groups'),
            )
          : null,
    );
  }

  void _openServerEdit(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const ServerEditScreen()));
  }

  Future<void> _browse(
      BuildContext context, WidgetRef ref, List<Server> servers) async {
    Server? target = servers.first;
    if (servers.length > 1) {
      target = await showModalBottomSheet<Server>(
        context: context,
        builder: (_) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final s in servers)
                ListTile(
                  leading: const Icon(Icons.dns),
                  title: Text(s.name),
                  onTap: () => Navigator.pop(context, s),
                ),
            ],
          ),
        ),
      );
    }
    if (target != null && context.mounted) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => BrowseGroupsScreen(server: target!)));
    }
  }
}

class _SubscriptionTile extends ConsumerWidget {
  final Server server;
  final Subscription sub;
  const _SubscriptionTile({required this.server, required this.sub});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey('sub-${sub.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Unsubscribe?'),
                content: Text('Stop following ${sub.groupName}?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel')),
                  FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Unsubscribe')),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) => ref
          .read(repositoryProvider)
          .unsubscribe(sub.serverId, sub.groupName),
      child: ListTile(
        title: Text(sub.groupName),
        subtitle: sub.description.isEmpty ? null : Text(sub.description,
            maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: sub.unreadCount > 0
            ? Badge(label: Text('${sub.unreadCount}'))
            : const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ArticleListScreen(server: server, subscription: sub),
        )),
      ),
    );
  }
}

class _ServersTab extends ConsumerWidget {
  const _ServersTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servers = ref.watch(serversProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Servers')),
      body: servers.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) {
          if (list.isEmpty) {
            return _EmptyState(
              icon: Icons.dns,
              title: 'No servers',
              message: 'Add your first NNTP server.',
              actionLabel: 'Add server',
              onAction: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const ServerEditScreen())),
            );
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final s = list[i];
              return ListTile(
                leading: Icon(s.useTls ? Icons.lock : Icons.lock_open),
                title: Text(s.name),
                subtitle: Text('${s.host}:${s.port}'
                    '${s.requiresAuth ? '  ·  ${s.username ?? ''}' : ''}'),
                trailing: IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: null,
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ServerEditScreen(server: s))),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ServerEditScreen())),
        icon: const Icon(Icons.add),
        label: const Text('Add server'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton(onPressed: onAction, child: Text(actionLabel)),
          ],
        ),
      ),
    );
  }
}
