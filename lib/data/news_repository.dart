import 'package:drift/drift.dart';

import '../nntp/nntp_client.dart';
import '../nntp/nntp_models.dart';
import 'credential_store.dart';
import 'database.dart';
import 'nntp_service.dart';

class SyncResult {
  final int newArticles;
  final int unreadCount;
  const SyncResult(this.newArticles, this.unreadCount);
}

class NewsRepository {
  final AppDatabase db;
  final NntpService nntp;
  final CredentialStore credentials;

  NewsRepository(this.db, this.nntp, this.credentials);

  Future<NntpConnection> _conn(int serverId) async {
    final server = await db.getServer(serverId);
    final pw = server.requiresAuth ? await credentials.getPassword(serverId) : null;
    return nntp.connectionFor(server, pw);
  }

  Future<void> testConnection(Server server, String? password) async {
    final conn = nntp.connectionFor(server, password);
    await conn.run((c) async {
      await c.ensureReaderMode();
      await c.sendCommand('DATE');
    });
  }

  /// Downloads the full group list for a server into the local catalog.
  Future<int> refreshCatalog(int serverId, {String? wildmat}) async {
    final conn = await _conn(serverId);
    return conn.run((c) async {
      final groups = await c.listActive(wildmat: wildmat);
      final descriptions = await c.listDescriptions(wildmat: wildmat);
      final rows = groups
          .map((g) => GroupCatalogCompanion.insert(
                serverId: serverId,
                groupName: g.name,
                description: Value(descriptions[g.name] ?? ''),
                high: Value(g.high),
                low: Value(g.low),
                postingStatus: Value(g.postingStatus),
              ))
          .toList();
      await db.replaceCatalog(serverId, rows);
      return rows.length;
    });
  }

  Future<List<GroupCatalogData>> searchGroups(int serverId, String query) =>
      db.searchCatalog(serverId, query);

  Future<void> subscribe(int serverId, GroupCatalogData group) =>
      db.subscribe(serverId, group.groupName, group.description);

  Future<void> unsubscribe(int serverId, String group) =>
      db.unsubscribe(serverId, group);

  /// Fetches recent overview headers for a subscription.
  Future<SyncResult> syncSubscription(
    Subscription sub, {
    int maxArticles = 500,
  }) async {
    final conn = await _conn(sub.serverId);
    return conn.run((c) async {
      final state = await c.selectGroup(sub.groupName);
      if (state.high == 0) {
        await db.updateSubscriptionSync(
            id: sub.id, serverHigh: 0, unreadCount: 0);
        return const SyncResult(0, 0);
      }
      var from = state.low;
      final windowStart = state.high - maxArticles + 1;
      if (windowStart > from) from = windowStart;
      if (sub.lastReadNumber + 1 > from && sub.lastReadNumber < state.high) {
        // Keep a little context before the last-read marker.
        final contextStart = sub.lastReadNumber - 50;
        if (contextStart > from) from = contextStart;
      }
      if (from < state.low) from = state.low;

      final records = await c.over(from, state.high);
      final rows = records
          .map((r) => ArticlesCompanion.insert(
                serverId: sub.serverId,
                groupName: sub.groupName,
                number: r.number,
                messageId: r.messageId,
                subject: Value(r.decodedSubject),
                fromRaw: Value(r.decodedFrom),
                authorName: Value(r.authorName),
                date: Value(r.parsedDate),
                references: Value(r.references.join(' ')),
                bytes: Value(r.bytes),
                lines: Value(r.lines),
                isRead: Value(r.number <= sub.lastReadNumber),
              ))
          .toList();
      await db.upsertOverviews(rows);
      await db.pruneOldArticles(sub.serverId, sub.groupName, from - 200);

      final unread = records.where((r) => r.number > sub.lastReadNumber).length;
      await db.updateSubscriptionSync(
        id: sub.id,
        serverHigh: state.high,
        unreadCount: unread,
      );
      return SyncResult(records.length, unread);
    });
  }

  /// Loads and caches the decoded body text of an article.
  Future<String> loadBody(Article article, {bool force = false}) async {
    if (!force && article.bodyText != null) return article.bodyText!;
    final conn = await _conn(article.serverId);
    final text = await conn.run((c) async {
      await c.selectGroup(article.groupName);
      RawArticle raw;
      try {
        raw = await c.fetchArticle('${article.number}');
      } on NntpException {
        raw = await c.fetchArticle(article.messageId);
      }
      return raw.decodeBody().text;
    });
    await db.saveBody(article.id, text);
    if (!article.isRead) {
      await db.setRead(article.id, true);
      await _recountUnread(article.serverId, article.groupName);
    }
    return text;
  }

  Future<RawArticle> loadRaw(Article article) async {
    final conn = await _conn(article.serverId);
    return conn.run((c) async {
      await c.selectGroup(article.groupName);
      try {
        return await c.fetchArticle('${article.number}');
      } on NntpException {
        return c.fetchArticle(article.messageId);
      }
    });
  }

  Future<void> markRead(Article article, bool read) async {
    await db.setRead(article.id, read);
    await _recountUnread(article.serverId, article.groupName);
  }

  Future<void> markGroupRead(int serverId, String group) async {
    await db.markGroupRead(serverId, group, true);
    await _recountUnread(serverId, group);
  }

  Future<void> toggleStar(Article article) =>
      db.setStarred(article.id, !article.isStarred);

  Future<void> _recountUnread(int serverId, String group) async {
    final sub = await db.findSubscription(serverId, group);
    if (sub == null) return;
    final all = await db.watchArticles(serverId, group).first;
    final unread = all.where((a) => !a.isRead).length;
    final maxRead = all
        .where((a) => a.isRead)
        .fold<int>(sub.lastReadNumber, (m, a) => a.number > m ? a.number : m);
    await db.updateSubscriptionSync(
        id: sub.id, serverHigh: sub.serverHigh, unreadCount: unread);
    if (maxRead > sub.lastReadNumber) {
      await db.setLastRead(sub.id, maxRead);
    }
  }

  Future<void> postArticle({
    required int serverId,
    required String from,
    required List<String> newsgroups,
    required String subject,
    required String body,
    List<String> references = const [],
  }) async {
    final conn = await _conn(serverId);
    await conn.run((c) async {
      final headers = <String, String>{
        'From': from,
        'Newsgroups': newsgroups.join(','),
        'Subject': subject,
        'User-Agent': 'mobilenntp',
      };
      if (references.isNotEmpty) {
        headers['References'] = references.join(' ');
        headers['In-Reply-To'] = references.last;
      }
      await c.post(headers: headers, body: body);
    });
  }
}
