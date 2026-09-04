import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/providers.dart';

class SyncStatus {
  final bool running;
  final DateTime? lastRun;
  final String? lastError;
  final int done;
  final int total;

  const SyncStatus({
    this.running = false,
    this.lastRun,
    this.lastError,
    this.done = 0,
    this.total = 0,
  });

  SyncStatus copyWith({
    bool? running,
    DateTime? lastRun,
    Object? lastError = _sentinel,
    int? done,
    int? total,
  }) {
    return SyncStatus(
      running: running ?? this.running,
      lastRun: lastRun ?? this.lastRun,
      lastError: lastError == _sentinel ? this.lastError : lastError as String?,
      done: done ?? this.done,
      total: total ?? this.total,
    );
  }

  static const _sentinel = Object();
}

/// Runs a periodic sync of every subscription while the app is alive, plus a
/// catch-up sync when the app returns to the foreground.
///
/// This is a foreground scheduler — true background sync (app suspended or
/// killed) would need platform background-task APIs.
class SyncService {
  final Ref _ref;
  Timer? _timer;
  int _intervalMinutes = 0;

  SyncService(this._ref);

  int get intervalMinutes => _intervalMinutes;

  void applyInterval(int minutes) {
    if (minutes == _intervalMinutes) return;
    _intervalMinutes = minutes;
    _timer?.cancel();
    _timer = null;
    if (minutes > 0) {
      _timer = Timer.periodic(Duration(minutes: minutes), (_) => syncAll());
    }
  }

  Future<void> maybeCatchUp() async {
    if (_intervalMinutes <= 0) return;
    final last = _ref.read(syncStatusProvider).lastRun;
    if (last == null ||
        DateTime.now().difference(last) >=
            Duration(minutes: _intervalMinutes)) {
      await syncAll();
    }
  }

  Future<void> syncAll() async {
    final statusCtrl = _ref.read(syncStatusProvider.notifier);
    if (_ref.read(syncStatusProvider).running) return;

    final db = _ref.read(databaseProvider);
    final repo = _ref.read(repositoryProvider);
    final subs = await db.watchAllSubscriptions().first;
    final settings = await db.getSettings();

    statusCtrl.state = _ref.read(syncStatusProvider).copyWith(
          running: true,
          lastError: null,
          done: 0,
          total: subs.length,
        );

    String? lastError;
    var done = 0;
    for (final sub in subs) {
      try {
        await repo.syncSubscription(sub,
            maxArticles: settings.maxArticlesPerSync);
      } catch (e) {
        lastError = '$e';
      }
      done++;
      statusCtrl.state =
          _ref.read(syncStatusProvider).copyWith(done: done);
    }

    statusCtrl.state = SyncStatus(
      running: false,
      lastRun: DateTime.now(),
      lastError: lastError,
      done: done,
      total: subs.length,
    );
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
