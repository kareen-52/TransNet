import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static SharedPreferences? _sharedPreferences;
  static const _secureStorage = FlutterSecureStorage();

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    await _sharedPreferences?.remove(key);
  }

  static Future<void> clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    await _sharedPreferences?.clear();
  }

  static Future<void> setData(String key, dynamic value) async {
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");
    if (value is String) {
      await _sharedPreferences?.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences?.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences?.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences?.setDouble(key, value);
    }
  }

  static bool getBool(String key) => _sharedPreferences?.getBool(key) ?? false;
  static double getDouble(String key) =>
      _sharedPreferences?.getDouble(key) ?? 0.0;
  static int getInt(String key) => _sharedPreferences?.getInt(key) ?? 0;
  static String getString(String key) =>
      _sharedPreferences?.getString(key) ?? '';


  static Future<void> setSecuredString(String key, String value) async {
    debugPrint('SecureStorage : set key : $key');
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String> getSecuredString(String key) async {
    debugPrint('SecureStorage : get key : $key');
    return await _secureStorage.read(key: key) ?? '';
  }

  static Future<void> removeSecuredData(String key) async {
    debugPrint('SecureStorage : deleted key : $key');
    await _secureStorage.delete(key: key);
  }

  //logout
  static Future<void> clearAllSecuredData() async {
    debugPrint('SecureStorage : all secured data cleared');
    await _secureStorage.deleteAll();
  }
}
