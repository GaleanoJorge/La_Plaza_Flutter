import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  
  void saveList(String key, List<String> value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList(key, value);
  }

  Future<List<String>?> readList(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getStringList(key);
  }
}