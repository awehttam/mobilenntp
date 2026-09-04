import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stores per-server passwords outside the main database.
class CredentialStore {
  final FlutterSecureStorage _storage;

  CredentialStore([FlutterSecureStorage? storage])
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  String _key(int serverId) => 'nntp_password_$serverId';

  Future<String?> getPassword(int serverId) => _storage.read(key: _key(serverId));

  Future<void> setPassword(int serverId, String? password) async {
    if (password == null || password.isEmpty) {
      await _storage.delete(key: _key(serverId));
    } else {
      await _storage.write(key: _key(serverId), value: password);
    }
  }

  Future<void> deletePassword(int serverId) =>
      _storage.delete(key: _key(serverId));
}
