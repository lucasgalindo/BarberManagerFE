import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<dynamic, dynamic>?> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userData = prefs.getString('user_info');
  if (userData != null) {
    return jsonDecode(userData) as Map<String, dynamic>;
  }
  return null;
}

Future<void> setUserData(Map<dynamic, dynamic> userInfo) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('user_info', jsonEncode(userInfo));
}
