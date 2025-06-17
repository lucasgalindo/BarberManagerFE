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

  void login(context, UserType? tipo) async {
      var result = await UserRepository.instance.findInDb(email, password);
    if (result == null) {
        return;
      }
      var custumer = Customer.fromJson(result);
    if (custumer.usuario!.tipo == "CLIENTE") {
        setUserData(result);
      approvedLogin(context, custumer.token);
    } else if (custumer.usuario!.tipo == "BARBEIRO") {
      setUserData(result);
      approvedLogin(context, custumer.token);
      }
  }
}
