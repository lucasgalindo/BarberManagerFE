import 'package:barbermanager_fe/models/user_creddentials.dart';
import 'package:flutter/material.dart';
import '../models/user_type_model.dart';

class InitialScreenViewModel extends ChangeNotifier {
  UserTypeModel? _selectedUser;

  UserTypeModel? get selectedUser => _selectedUser;

  void selectUser(UserType type) {
    _selectedUser = UserTypeModel(userType: type);
    notifyListeners();
  }

  void goToNextScreen(BuildContext context) {
    if (_selectedUser == null) return;
    setTypeUser(_selectedUser!.userType.valor);
    switch (_selectedUser!.userType) {
      case UserType.cliente:
        Navigator.pushNamed(context, '/login');
        break;
      case UserType.barbeiro:

        Navigator.pushNamed(context, '/login');
        break;
      case UserType.donoBarbearia:

        Navigator.pushNamed(context, '/login');
        break;
    }
  }
}
