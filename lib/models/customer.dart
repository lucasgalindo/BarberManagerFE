import 'package:barbermanager_fe/models/abstractions/IUser.dart';
import 'package:barbermanager_fe/view_models/first_entry_view_model.dart';

class Customer implements IUser {
  String completeName;
  @override
  String email;
  @override
  String password;
  String phone;
  String birthday;
  PreferenceChoices choice;
  String token;
  Customer(
    this.completeName,
    this.email,
    this.password,
    this.phone,
    this.birthday,
    this.choice,
    this.token
  );

  factory Customer.fromMap(Map<dynamic, dynamic> map) {
    return Customer(
      map["completeName"],
      map["email"],
      map["password"],
      map["phone"],
      map["birthday"],
      map["choice"],
      map["token"]
    );
  }
  
  @override
  Map<String, dynamic> toMap() {
    return {
       "completeName": completeName,
       "email": email,
       "password": password,
       "phone": phone,
       "birthday": birthday,
       "choice": choice.index,
       "token": token,
    };
  }
  
}
