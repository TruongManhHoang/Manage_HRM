import 'package:hive/hive.dart';

class StorageLocal {
  static const String _userBox = 'userBox';
  static const String _tokenKey = 'token';
  static const String _emailKey = 'email';
  static const String _displayNameKey = 'displayName';

  static Future<void> saveUser({
    required String token,
    required String email,
    required String displayName,
  }) async {
    final box = await Hive.openBox(_userBox);
    await box.put(_tokenKey, token);
    await box.put(_emailKey, email);
    await box.put(_displayNameKey, displayName);
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final box = await Hive.openBox(_userBox);
    if (box.containsKey(_tokenKey)) {
      return {
        'token': box.get(_tokenKey),
        'email': box.get(_emailKey),
        'displayName': box.get(_displayNameKey),
      };
    }
    return null;
  }

  static Future<void> clearUser() async {
    final box = await Hive.openBox(_userBox);
    await box.clear();
  }
}
