import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static late  SharedPreferences sharedPref;

  static Future<void>initSharedPref() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<dynamic> sharedPrefSet({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPref.setString(key, value);
    if (value is int) return await sharedPref.setInt(key, value);
    if (value is double) return await sharedPref.setDouble(key, value);
    return await sharedPref.setBool(key, value);
  }

  static dynamic sharedPrefGet({
    required String key,
  }) async {
    return sharedPref.get(key);
  }
}
