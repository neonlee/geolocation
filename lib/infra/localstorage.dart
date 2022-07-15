import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _sharedPreferences;

  LocalStorage({required Future<SharedPreferences> sharedPreferences}) {
    initialize(sharedPreferences);
  }

  void initialize(Future<SharedPreferences> sharedPreferences) async {
    _sharedPreferences = await sharedPreferences;
  }

  Future<bool> saveString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }
}
