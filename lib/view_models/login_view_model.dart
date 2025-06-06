import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/models/customer.dart';
import 'package:barbermanager_fe/models/user_type_model.dart';
import 'package:barbermanager_fe/repositories/user_repository.dart';
import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:barbermanager_fe/view_models/auth_provider.dart';
import 'package:barbermanager_fe/view_models/first_entry_view_model.dart';
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

  void login(context, UserType? tipo) {
    if (tipo != null) {
      var result = UserRepository.instance.findInDb(email, password);
      if (result != null &&
          result is Barberautonomos &&
          tipo == UserType.barbeiro) {
        approvedLogin(context, result.token);
        setUserData(result.toMap());
      }
      if (result != null && result is Customer && tipo == UserType.cliente) {
        if (result.choice != PreferenceChoices.none) {
          setUserData(result.toMap());
          approvedLogin(context, result.token);
        } else {
          setUserData(result.toMap());
          firstLogin(context, result.token);
        }
      }
    }
  }
}
