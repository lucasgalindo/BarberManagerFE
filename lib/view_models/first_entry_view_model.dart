
  import 'package:barbermanager_fe/models/jwt.dart';
import 'package:barbermanager_fe/repositories/user_repository.dart';
import 'package:flutter/material.dart';

enum PreferenceChoices {
  barber,
  barberStore,
  none
  }

class FirstEntryViewModel extends ChangeNotifier {
  
  
  PreferenceChoices choice = PreferenceChoices.none;


  nextScreen(int choice, context) async{
    this.choice = PreferenceChoices.values[choice];
    var token = await getToken();
    if (token == null) {
      return;
    }
    switch (this.choice) {
      case PreferenceChoices.barber:
        Navigator.of(context).pushNamed(
          '/home',
          arguments: {"search": "barbeiros"},
        );

      case PreferenceChoices.barberStore:
        Navigator.of(context).pushNamed(
          '/home',
          arguments: {"search": "barbearias"},
        );
      
      default:
        
        break;
    }
  }







}


