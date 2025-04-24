import 'package:flutter/material.dart';
import '../models/userTypeModel.dart';

class InitialScreenViewModel extends ChangeNotifier {
  UserTypeModel? _selectedUser;

  UserTypeModel? get selectedUser => _selectedUser;

  void selectUser(UserType type) {
    _selectedUser = UserTypeModel(userType: type);
    notifyListeners();
  }

  void goToNextScreen(BuildContext context) {
    if (_selectedUser == null) return;

    switch (_selectedUser!.userType) {
      case UserType.cliente:
        Navigator.pushNamed(context, '/login',  arguments: {
          "user" : 0,
        });
        break;
      case UserType.barbeiro:
        Navigator.pushNamed(context, '/login', arguments: {
          "user" : 1,
        });
        break;
      case UserType.donoBarbearia:
        Navigator.pushNamed(context, '/login',  arguments: {
          "user" : 2,
        });
        break;
    }
  }
}
