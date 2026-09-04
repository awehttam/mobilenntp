import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/credential_store.dart';
import '../data/database.dart';
import '../data/news_repository.dart';
import '../data/nntp_service.dart';
import '../data/sync_service.dart';
import '../logic/threading.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final nntpServiceProvider = Provider<NntpService>((ref) {
  final service = NntpService();
  ref.onDispose(service.disposeAll);
  return service;
});

final credentialStoreProvider = Provider<CredentialStore>((ref) => CredentialStore());

final repositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepository(
    ref.watch(databaseProvider),
    ref.watch(nntpServiceProvider),
    ref.watch(credentialStoreProvider),
  );
});

final serversProvider = StreamProvider<List<Server>>((ref) {
  return ref.watch(databaseProvider).watchServers();
});

final settingsProvider = StreamProvider<AppSetting>((ref) {
  return ref.watch(databaseProvider).watchSettings();
});

final syncStatusProvider = StateProvider<SyncStatus>((ref) => const SyncStatus());

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(ref);
  ref.onDispose(service.dispose);
  return service;
});

final allSubscriptionsProvider = StreamProvider<List<Subscription>>((ref) {
  return ref.watch(databaseProvider).watchAllSubscriptions();
});

final subscriptionsForServerProvider =
    StreamProvider.family<List<Subscription>, int>((ref, serverId) {
  return ref.watch(databaseProvider).watchSubscriptions(serverId);
});

class GroupKey {
  final int serverId;
  final String group;
  const GroupKey(this.serverId, this.group);
  @override
  bool operator ==(Object other) =>
      other is GroupKey && other.serverId == serverId && other.group == group;
  @override
  int get hashCode => Object.hash(serverId, group);
}

final articlesProvider =
    StreamProvider.family<List<Article>, GroupKey>((ref, key) {
  return ref.watch(databaseProvider).watchArticles(key.serverId, key.group);
});

/// View mode for the article list.
enum ArticleListMode { threaded, flat, unreadOnly }

final articleListModeProvider =
    StateProvider<ArticleListMode>((ref) => ArticleListMode.threaded);

final threadsProvider =
    Provider.family<List<ThreadNode>, GroupKey>((ref, key) {
  final articles = ref.watch(articlesProvider(key)).valueOrNull ?? const [];
  final mode = ref.watch(articleListModeProvider);
  final filtered = mode == ArticleListMode.unreadOnly
      ? articles.where((a) => !a.isRead).toList()
      : articles;
  if (mode == ArticleListMode.flat) {
    final sorted = [...filtered]
      ..sort((a, b) => (b.date ?? DateTime(0)).compareTo(a.date ?? DateTime(0)));
    return sorted.map((a) => ThreadNode(a)).toList();
  }
  return buildThreads(filtered);
});
