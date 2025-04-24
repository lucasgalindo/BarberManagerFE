import 'package:flutter/material.dart';
import '../models/userModel.dart';

class RegisterViewModel extends ChangeNotifier {
  UserModel user = UserModel();
  bool agreeToTerms = false;
  bool formValid = false;

  void updateUsername(String value) {
    user.username = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    user.email = value;
    notifyListeners();
  }

  void updatePhone(String value) {
    user.phone = value;
    notifyListeners();
  }

  void updateBirthDate(String value) {
    user.birthDate = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    user.password = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    user.confirmPassword = value;
    notifyListeners();
  }

  void toggleAgreeToTerms(bool? value) {
    agreeToTerms = value ?? false;
    notifyListeners();
  }

  bool validateForm() {
    return user.username.isNotEmpty &&
        user.email.isNotEmpty &&
        user.phone.isNotEmpty &&
        user.birthDate.isNotEmpty &&
        user.password.isNotEmpty &&
        user.confirmPassword == user.password &&
        agreeToTerms;
  }

  void submit() {
    if (validateForm()) {
      print(user.phone);
    } else {
      // mostrar erro
    }
  }
}
