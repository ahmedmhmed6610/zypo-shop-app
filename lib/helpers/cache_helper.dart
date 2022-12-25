import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageKeys {
  StorageKeys();

  //Declare all storage keys here & create its correpsonding setters & getters
  static const String token = "TOKEN";
  static const String language = "lan";

}

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  get getToken {
    return sharedPreferences.getString(StorageKeys.token) ?? "";
  }

  setToken(String token) {
    sharedPreferences.setString(StorageKeys.token, token);
  }
  get getLanguage {
    return sharedPreferences.getString(StorageKeys.language) ?? "";
  }

  setLanguage(String token) {
    sharedPreferences.setString(StorageKeys.language, token);
  }

  static Future<bool> saveData({required String key, dynamic value}) {
    if (value is bool) {
      return sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return sharedPreferences.setString(key, value);
    } else if (value is double) {
      return sharedPreferences.setDouble(key, value);
    } else {
      return sharedPreferences.setInt(key, value);
    }
  }

  static dynamic getData({required String key}) => sharedPreferences.get(key);

  static Future<bool> removeData({required String key}) =>
      sharedPreferences.remove(key);
}
