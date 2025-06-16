
import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/models/customer.dart';
import 'package:barbermanager_fe/models/user_creddentials.dart';
import 'package:barbermanager_fe/models/user_type_model.dart';
import 'package:barbermanager_fe/repositories/user_repository.dart';
import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:barbermanager_fe/view_models/auth_provider.dart';
import 'package:barbermanager_fe/view_models/first_entry_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterViewModel extends ChangeNotifier {
  dynamic? user = null;
  String? username = null;
  String? email = null;
  String cpf = "";
  String phone = "";
  String? birthDate = null;
  String? password = null;
  String? confirmPassword = null;

  bool agreeToTerms = false;
  bool formValid = false;

  void updateUsername(String value) {
    username = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updateCpf(String value) {
    cpf = value;
    notifyListeners();
  }

  void updatePhone(String value) {
    phone = value;
    notifyListeners();
  }

  void updateBirthDate(String value) {
    birthDate = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  void toggleAgreeToTerms(bool? value) {
    agreeToTerms = value ?? false;
    notifyListeners();
  }

  bool validateForm() {
    return username != null &&
        email != null &&
        phone != null &&
        birthDate != null &&
        password != null &&
        confirmPassword == password &&
        agreeToTerms;
  }

  void submit(context) {
    
  }
}
