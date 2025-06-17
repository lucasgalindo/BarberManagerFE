import 'package:barbermanager_fe/models/user_creddentials.dart';
import 'package:barbermanager_fe/models/user_type_model.dart';
import 'package:barbermanager_fe/repositories/user_repository.dart';
import 'package:barbermanager_fe/view_models/login_view_model.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  dynamic? user = null;
  String? username = null;
  String? email = null;
  String endereco = "";
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

  void updateEndereco(String value) {
    endereco = value;
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
        password != null &&
        confirmPassword == password &&
        agreeToTerms;
  }

  void submit(context) async {
    if (validateForm()) {
      var user = {
        "nome": username,
        "email": email!.toLowerCase(),
        "senha": password,
        "endereco": endereco,
        "tipo": "CLIENTE",
      };
      int? type = await getTypeUser();
      if (UserType.fromInt(type!) == UserType.cliente) {
        UserRepository.instance.saveInDb(user);
        LoginViewModel().updateEmail(email!);
        LoginViewModel().updatePassword(password!);
      } else if (UserType.fromInt(type) == UserType.barbeiro) {
        user["tipo"] = "Barbeiro";
        UserRepository.instance.saveInDb(user);
        LoginViewModel().updateEmail(email!);
        LoginViewModel().updatePassword(password!);
      } else if (UserType.fromInt(type) == UserType.donoBarbearia) {
        user["tipo"] = "dono_barbearia";
        UserRepository.instance.saveInDb(user);
        LoginViewModel().updateEmail(email!);
        LoginViewModel().updatePassword(password!);
      }
        LoginViewModel().login(context, UserType.cliente);
    }
  }
}
