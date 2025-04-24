import 'package:flutter/material.dart';

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

  void login() {
    if (email.isNotEmpty && password.isNotEmpty) {
      print("Login com: $email e $password");
      // Aqui poderia chamar um AuthService, Firebase, etc.
    } else {
      print("Preencha todos os campos!");
    }
  }
}
