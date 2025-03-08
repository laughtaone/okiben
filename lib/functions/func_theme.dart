import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


// 読み込み関数
Future<String?> funcLoadTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? keep = prefs.getString('theme');

  if (keep != null) {
    return keep;
  }
  return null;
}


// 書き込み関数
Future<bool> funcWriteTheme(String theme) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  debugPrint(await funcLoadTheme());
  return await prefs.setString('theme', theme);
}
