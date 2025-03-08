import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';



Future<bool> funcSaveItemList({required List<Map<String, dynamic>> itemList}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString('itemList', json.encode(itemList));
    return result;
  } catch (e) {
    // エラーハンドリング
    debugPrint('Error saving item list: $e');
    return false;
  }
}