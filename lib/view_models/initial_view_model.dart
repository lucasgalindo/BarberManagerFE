import 'package:barbermanager_fe/models/user_creddentials.dart';
import 'package:flutter/material.dart';
import '../models/user_type_model.dart';

class InitialScreenViewModel extends ChangeNotifier {
  UserType? _selectedUser;

  UserType? get selectedUser => _selectedUser;

  void selectUser(UserType type) {
    _selectedUser = type;
    notifyListeners();
  }
  

  void goToNextScreen(BuildContext context) async{
    if (_selectedUser == null) return;
    await setTypeUser(_selectedUser!.valor);
    Navigator.pushNamed(context, '/login', arguments: selectedUser);
  }
}
