import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyEmail = 'email';
  static const _keyAuth = 'authorization';

  static Future setEmail(String email) async =>
      await _storage.write(key: _keyEmail, value: email);

  static Future<String?> getEmail() async =>
      await _storage.read(key: _keyEmail);

  static Future setAuth(String authorization) async =>
      await _storage.write(key: _keyAuth, value: authorization);

  static Future<String?> getAuth() async =>
      await _storage.read(key: _keyAuth);
}