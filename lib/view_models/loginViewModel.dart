import 'package:barbermanager_fe/view_models/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  String email = '';
  String password = '';

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void login(context) {
    Provider.of<AuthProvider>(context, listen: false).login();
    Navigator.pushReplacementNamed(context, '/home');
  }
}
