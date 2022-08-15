import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

saveStringValue() async {
  prefs = await SharedPreferences.getInstance();
  prefs?.setString("username", "naresh");
}

getString() async {
  prefs = await SharedPreferences.getInstance();
  String? value = prefs?.getString("username");
  print(value);
}
