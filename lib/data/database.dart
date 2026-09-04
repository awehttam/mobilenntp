import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Servers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get host => text()();
  IntColumn get port => integer().withDefault(const Constant(119))();
  BoolColumn get useTls => boolean().withDefault(const Constant(false))();
  BoolColumn get allowBadCertificate =>
      boolean().withDefault(const Constant(false))();
  TextColumn get username => text().nullable()();
  BoolColumn get requiresAuth => boolean().withDefault(const Constant(false))();
  /// Posting identity: optional display name and the email address used in the
  /// `From` header (required before posting).
  TextColumn get fromName => text().nullable()();
  TextColumn get email => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

/// Single-row application settings (id is always 1).
class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get syncIntervalMinutes =>
      integer().withDefault(const Constant(0))();
  IntColumn get maxArticlesPerSync =>
      integer().withDefault(const Constant(500))();

  @override
  Set<Column> get primaryKey => {id};
}

class Subscriptions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get serverId =>
      integer().references(Servers, #id, onDelete: KeyAction.cascade)();
  TextColumn get groupName => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get lastReadNumber => integer().withDefault(const Constant(0))();
  IntColumn get serverHigh => integer().withDefault(const Constant(0))();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {serverId, groupName}
      ];
}

/// Cached catalog of all groups on a server (for browsing / subscribing).
class GroupCatalog extends Table {
  IntColumn get serverId =>
      integer().references(Servers, #id, onDelete: KeyAction.cascade)();
  TextColumn get groupName => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get high => integer().withDefault(const Constant(0))();
  IntColumn get low => integer().withDefault(const Constant(0))();
  TextColumn get postingStatus => text().withDefault(const Constant('y'))();

  @override
  Set<Column> get primaryKey => {serverId, groupName};
}

class Articles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get serverId =>
      integer().references(Servers, #id, onDelete: KeyAction.cascade)();
  TextColumn get groupName => text()();
  IntColumn get number => integer()();
  TextColumn get messageId => text()();
  TextColumn get subject => text().withDefault(const Constant(''))();
  TextColumn get fromRaw => text().withDefault(const Constant(''))();
  TextColumn get authorName => text().withDefault(const Constant(''))();
  DateTimeColumn get date => dateTime().nullable()();
  TextColumn get references => text().withDefault(const Constant(''))();
  IntColumn get bytes => integer().withDefault(const Constant(0))();
  IntColumn get lines => integer().withDefault(const Constant(0))();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  BoolColumn get isStarred => boolean().withDefault(const Constant(false))();
  TextColumn get bodyText => text().nullable()();
  DateTimeColumn get bodyFetchedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {serverId, groupName, number}
      ];
}

@DriftDatabase(
    tables: [Servers, Subscriptions, GroupCatalog, Articles, AppSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_open());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await into(appSettings)
              .insert(const AppSettingsCompanion(id: Value(1)));
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(servers, servers.fromName);
            await m.addColumn(servers, servers.email);
            await m.createTable(appSettings);
            await into(appSettings).insert(
                const AppSettingsCompanion(id: Value(1)),
                mode: InsertMode.insertOrIgnore);
          }
        },
      );

  // ---- Settings ----
  Stream<AppSetting> watchSettings() =>
      (select(appSettings)..where((s) => s.id.equals(1)))
          .watchSingleOrNull()
          .map((r) =>
              r ??
              const AppSetting(
                id: 1,
                syncIntervalMinutes: 0,
                maxArticlesPerSync: 500,
              ));

  Future<AppSetting> getSettings() => watchSettings().first;

  Future<void> setSyncIntervalMinutes(int minutes) {
    return into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion(
          id: const Value(1), syncIntervalMinutes: Value(minutes)),
    );
  }

  // ---- Servers ----
  Future<List<Server>> allServers() =>
      (select(servers)..orderBy([(s) => OrderingTerm(expression: s.sortOrder)]))
          .get();

  Stream<List<Server>> watchServers() =>
      (select(servers)..orderBy([(s) => OrderingTerm(expression: s.sortOrder)]))
          .watch();

  Future<Server> getServer(int id) =>
      (select(servers)..where((s) => s.id.equals(id))).getSingle();

  Future<int> insertServer(ServersCompanion c) => into(servers).insert(c);
  Future<bool> updateServer(Server s) => update(servers).replace(s);
  Future<int> deleteServer(int id) =>
      (delete(servers)..where((s) => s.id.equals(id))).go();

  // ---- Subscriptions ----
  Stream<List<Subscription>> watchSubscriptions(int serverId) =>
      (select(subscriptions)
            ..where((s) => s.serverId.equals(serverId))
            ..orderBy([(s) => OrderingTerm(expression: s.sortOrder)]))
          .watch();

  Stream<List<Subscription>> watchAllSubscriptions() => (select(subscriptions)
        ..orderBy([(s) => OrderingTerm(expression: s.sortOrder)]))
      .watch();

  Future<Subscription?> findSubscription(int serverId, String group) =>
      (select(subscriptions)
            ..where((s) => s.serverId.equals(serverId) & s.groupName.equals(group)))
          .getSingleOrNull();

  Future<int> subscribe(int serverId, String group, String description) {
    return into(subscriptions).insert(
      SubscriptionsCompanion.insert(
        serverId: serverId,
        groupName: group,
        description: Value(description),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  Future<void> unsubscribe(int serverId, String group) => (delete(subscriptions)
        ..where((s) => s.serverId.equals(serverId) & s.groupName.equals(group)))
      .go();

  Future<void> updateSubscriptionSync({
    required int id,
    required int serverHigh,
    required int unreadCount,
  }) {
    return (update(subscriptions)..where((s) => s.id.equals(id))).write(
      SubscriptionsCompanion(
        serverHigh: Value(serverHigh),
        unreadCount: Value(unreadCount),
        lastSyncedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setLastRead(int subscriptionId, int number) {
    return (update(subscriptions)..where((s) => s.id.equals(subscriptionId)))
        .write(SubscriptionsCompanion(lastReadNumber: Value(number)));
  }

  // ---- Group catalog ----
  Future<void> replaceCatalog(int serverId, List<GroupCatalogCompanion> rows) async {
    await batch((b) {
      b.deleteWhere(groupCatalog, (t) => t.serverId.equals(serverId));
      b.insertAll(groupCatalog, rows, mode: InsertMode.insertOrReplace);
    });
  }

  Future<List<GroupCatalogData>> searchCatalog(int serverId, String query,
      {int limit = 200}) {
    final q = select(groupCatalog)..where((g) => g.serverId.equals(serverId));
    if (query.trim().isNotEmpty) {
      final like = '%${query.trim()}%';
      q.where((g) => g.groupName.like(like) | g.description.like(like));
    }
    q
      ..orderBy([(g) => OrderingTerm(expression: g.groupName)])
      ..limit(limit);
    return q.get();
  }

  Future<int> catalogCount(int serverId) async {
    final c = countAll();
    final row = await (selectOnly(groupCatalog)
          ..addColumns([c])
          ..where(groupCatalog.serverId.equals(serverId)))
        .getSingle();
    return row.read(c) ?? 0;
  }

  // ---- Articles ----
  Stream<List<Article>> watchArticles(int serverId, String group) =>
      (select(articles)
            ..where((a) => a.serverId.equals(serverId) & a.groupName.equals(group))
            ..orderBy([(a) => OrderingTerm(expression: a.number)]))
          .watch();

  Future<Article?> getArticle(int id) =>
      (select(articles)..where((a) => a.id.equals(id))).getSingleOrNull();

  Future<void> upsertOverviews(List<ArticlesCompanion> rows) async {
    await batch((b) {
      for (final r in rows) {
        b.insert(
          articles,
          r,
          onConflict: DoUpdate(
            (old) => ArticlesCompanion(
              subject: r.subject,
              fromRaw: r.fromRaw,
              authorName: r.authorName,
              date: r.date,
              references: r.references,
              bytes: r.bytes,
              lines: r.lines,
              messageId: r.messageId,
            ),
            target: [articles.serverId, articles.groupName, articles.number],
          ),
        );
      }
    });
  }

  Future<void> saveBody(int articleId, String body) {
    return (update(articles)..where((a) => a.id.equals(articleId))).write(
      ArticlesCompanion(
        bodyText: Value(body),
        bodyFetchedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setRead(int articleId, bool read) {
    return (update(articles)..where((a) => a.id.equals(articleId)))
        .write(ArticlesCompanion(isRead: Value(read)));
  }

  Future<void> markGroupRead(int serverId, String group, bool read) {
    return (update(articles)
          ..where((a) => a.serverId.equals(serverId) & a.groupName.equals(group)))
        .write(ArticlesCompanion(isRead: Value(read)));
  }

  Future<void> setStarred(int articleId, bool starred) {
    return (update(articles)..where((a) => a.id.equals(articleId)))
        .write(ArticlesCompanion(isStarred: Value(starred)));
  }

  Future<int> pruneOldArticles(int serverId, String group, int keepFromNumber) {
    return (delete(articles)
          ..where((a) =>
              a.serverId.equals(serverId) &
              a.groupName.equals(group) &
              a.number.isSmallerThanValue(keepFromNumber) &
              a.isStarred.equals(false)))
        .go();
  }
}

LazyDatabase _open() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'mobilenntp.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
