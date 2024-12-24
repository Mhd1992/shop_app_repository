import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static ini() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> setData({required key, required value}) async {
    return await sharedPreferences?.setBool(key, value);
  }

  static dynamic getData({required key}) {
    return sharedPreferences?.get(key);
  }

  static Future<bool> saveData(
      {required String key,  dynamic value}) async {
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);

    return await sharedPreferences!.setDouble(key, value);
  }

  static Future<bool> removeKey(
      {required String key}) async {

    return await sharedPreferences!.remove(key);
  }

/*  static Future<bool> getData(
      {required String key, required dynamic value}) async {
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);

    return await sharedPreferences!.setDouble(key, value);
  }*/
}
