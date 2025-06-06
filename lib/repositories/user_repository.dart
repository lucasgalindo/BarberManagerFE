import 'package:barbermanager_fe/models/abstractions/IUser.dart';
import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/models/customer.dart';
import 'package:barbermanager_fe/view_models/first_entry_view_model.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();

  UserRepository._internal();

  static UserRepository get instance => _instance;

  List<IUser?> db = [
    Customer(
      "Anthony Lima",
      "cliente@teste.com",
      "senha123",
      "81996238709",
      "2004-09-20",
      PreferenceChoices.none,
      "addoaska.1230193nsnos",
    ),
    Barberautonomos.fromMap({
      "email": "barbeiro@teste.com",
      "password": "teste123",
      "id": "3",
      "name": "Lucas Almeida",
      "imageUrl":
          "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
      "description": "Especialista em cortes premium.",
      "rating": 4.9,
      "phone": "(31) 77777-7777",
      "address": "Praça dos Cabelos, 789",
      "workingHours": {
        "Seg": "08:00 - 20:00",
        "Ter": "08:00 - 20:00",
        "Qua": "08:00 - 20:00",
        "Qui": "08:00 - 20:00",
        "Sex": "08:00 - 20:00",
        "Sáb": "09:00 - 15:00",
        "Dom": "Fechado",
      },
      "services": [
        BarberService(
          "Corte Premium",
          60.0,
          "45min",
          "Corte",
          "Corte premium com finalização.",
        ),
        BarberService(
          "Barba Completa",
          35.0,
          "25min",
          "Barba",
          "Barba completa com toalha quente.",
        ),
      ],
    }),
  ];

  IUser? findInDb(String email, String password) {
    final datum = db.firstWhere(
      (item) =>
          item?.email.toLowerCase() == email.toLowerCase() &&
          item?.password == password,
      orElse: () => null
    );
    if(datum != null){  
      return datum;
    }
    return null;

  }

  void updatePreference(preference, token) {
      print(token);
      final user = db.firstWhere(
        (u) => u is Customer && u.token == token,
        orElse: () => null
      );
    
    if (user is Customer) {
      user.choice = preference;
      changeRecord(user);
    } else {
      print("User not found or not a Customer.");
    }
  }

  void changeRecord(IUser user){
    final existingUserIndex = db.indexWhere((u) => u?.email == user.email);
    
    if (existingUserIndex != -1) {
      // Update existing user
      db[existingUserIndex] = user;
    } else {
      // Add new user
      db.add(user);
    }
  }


  void saveInDb(IUser user) {
    final existingUserIndex = db.indexWhere((u) => u?.email == user.email);
    
    if (existingUserIndex != -1) {
      // Update existing user
      db[existingUserIndex] = user;
    } else {
      // Add new user
      db.add(user);
    }
    
  }
}
