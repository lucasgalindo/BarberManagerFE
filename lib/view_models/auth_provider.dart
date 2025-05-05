import 'package:barbermanager_fe/models/jwt.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  
  void login(token) {
    saveToken(token);
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout(context) {
    _isLoggedIn = false;
    removeToken();
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => true);
  }
}
