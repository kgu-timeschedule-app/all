import 'dart:async'; //非同期処理用

import 'package:shared_preferences/shared_preferences.dart';

Future<int> readLocalstrageSettingInt(String dbname) async {
  int result = 0;
  final prefs = await SharedPreferences.getInstance();
  // print("READDDD");
  if (prefs.getInt(dbname) == null) {
    result = 1;
  } else {
    result = prefs.getInt(dbname) ?? 0;
  }
  return result;
}

Future<bool> setLocalstrageSettingInt(int termIndex, String dbname) async {
  final prefs = await SharedPreferences.getInstance();
  // print("SETTTTT");
  prefs.setInt(dbname, termIndex);
  return true;
}

Future<bool> setLocalstrageSettingBool(bool isRemove, String dbname) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(dbname, isRemove);

  return true;
}

Future<bool> readLocalstrageSettingBool(String dbname) async {
  bool settingBool = true;
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(dbname) == null) {
    settingBool = true;
  } else {
    settingBool = prefs.getBool(dbname) ?? true;
  }

  return settingBool;
}

Future<String> readLocalstrageSettingString(String dbname) async {
  String result;
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString(dbname) == null) {
    return "";
  } else {
    result = prefs.getString(dbname) ?? "";
  }
  return result;
}

Future<bool> setLocalstrageSettingString(
    String termIndex, String dbname) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(dbname, termIndex);
  return true;
}
