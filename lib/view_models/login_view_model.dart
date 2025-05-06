import 'package:barbermanager_fe/repositories/user_repository.dart';
import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:barbermanager_fe/view_models/auth_provider.dart';
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

  void approvedLogin(context, token) {
    Provider.of<AuthProvider>(context, listen: false).login(token);
    Navigator.pushNamed(context, '/home');
  }

  void firstLogin(context, token) {
    Provider.of<AuthProvider>(context, listen: false).login(token);
    Navigator.pushNamed(context, '/first_entry');
  }

  void login(context) {
    var result = UserRepository.instance.findInDb(email, password);
    if (result.isNotEmpty) {
      setUserData(result);
      if (result["preference"] == null) {
        firstLogin(context, result["token"]);
        return;
      } else {
        approvedLogin(context, result["token"]);
        return;
      }
    }
  }
}
