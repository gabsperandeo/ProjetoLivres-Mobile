import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DateSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyDate = 'date';

  static Future setDate(String? date) async =>
      await _storage.write(key: _keyDate, value: date);

  static Future<String?> getDate() async =>
      await _storage.read(key: _keyDate);
}