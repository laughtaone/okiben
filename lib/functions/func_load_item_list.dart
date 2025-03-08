
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


Future<List<Map<String, dynamic>>> funcLoadItemList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? itemListString = prefs.getString('itemList');
  if (itemListString != null) {
    return List<Map<String, dynamic>>.from(json.decode(itemListString));
  }
  return [];
}