import 'dart:async';

import '../data/database.dart';
import '../nntp/nntp_client.dart';

/// Serializes access to one [NntpClient] per server and reconnects on demand.
class NntpConnection {
  final int serverId;
  NntpServerConfig _config;
  NntpClient? _client;
  Future<void> _lock = Future.value();

  NntpConnection(this.serverId, this._config);

  void updateConfig(NntpServerConfig config) {
    _config = config;
    // Force a reconnect with new settings on next use.
    final old = _client;
    _client = null;
    old?.close();
  }

  Future<T> run<T>(Future<T> Function(NntpClient client) action) {
    final completer = Completer<T>();
    _lock = _lock.then((_) async {
      try {
        final client = await _ensureClient();
        completer.complete(await action(client));
      } catch (e, st) {
        // Drop a broken connection so the next call reconnects.
        if (e is NntpException && e.code == -1) {
          await _client?.close();
          _client = null;
        }
        completer.completeError(e, st);
      }
    });
    return completer.future;
  }

  Future<NntpClient> _ensureClient() async {
    final existing = _client;
    if (existing != null && existing.isConnected) return existing;
    final client = NntpClient(_config);
    await client.connect();
    await client.ensureReaderMode();
    _client = client;
    return client;
  }

  Future<void> dispose() async {
    await _client?.close();
    _client = null;
  }
}

class NntpService {
  final Map<int, NntpConnection> _connections = {};

  NntpConnection connectionFor(Server server, String? password) {
    final config = NntpServerConfig(
      host: server.host,
      port: server.port,
      useTls: server.useTls,
      allowBadCertificate: server.allowBadCertificate,
      username: server.requiresAuth ? server.username : null,
      password: server.requiresAuth ? password : null,
    );
    final existing = _connections[server.id];
    if (existing != null) {
      existing.updateConfig(config);
      return existing;
    }
    final conn = NntpConnection(server.id, config);
    _connections[server.id] = conn;
    return conn;
  }

  Future<void> disconnect(int serverId) async {
    await _connections.remove(serverId)?.dispose();
  }

  Future<void> disposeAll() async {
    for (final c in _connections.values) {
      await c.dispose();
    }
    _connections.clear();
  }
}
