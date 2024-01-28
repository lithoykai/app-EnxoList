import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StoreData {
  static Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool?> saveMap(String key, Map<String, dynamic> value) async {
    saveString(key, jsonEncode(value));
  }

  static Future<String> getString(String key,
      [String defaultValue = '']) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? defaultValue;
  }

  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      return jsonDecode(await getString(key));
    } catch (_) {
      return {};
    }
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<bool?> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool?> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
