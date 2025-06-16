
import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/models/customer.dart';
import 'package:barbermanager_fe/view_models/first_entry_view_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  static String url = "https://barbermanager-preview.onrender.com";
  UserRepository._internal();
  static String token = "";
  static UserRepository get instance => _instance;
  

  Future<dynamic> findInDb(String email, String password) async{
    var response = await http.post(
    Uri.parse("${url}/auth/login"),
    headers: {
      "Content-Type": "application/json"
    },
    body: jsonEncode({
      "email": email,
      "senha": password
    })); 
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      token = data["token"];
      return data;

  } else {
    print('Erro: ${response.statusCode}');
    return null;
  }
  }
  





  
  void saveInDb(dynamic user) {

  }
}
