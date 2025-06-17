import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'dart:convert';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  static String url = "http://localhost:8080";
  UserRepository._internal();
  static String token = "";
  static UserRepository get instance => _instance;


  Future<bool> cancelarAgendamento(int id) async{
    try{
    var data = await getUserData();
    String token_valido = data!["token"];
    var response = await http.delete(
      Uri.parse("${url}/agendamentos/cancelar/$id"),
      headers: {"Authorization": "Bearer $token_valido"}
    );
    if(response.statusCode == 204){
      return true;
    }
    return false;
    }
    catch(e){
      print("Erro ao cancelar:" + e.toString());
      return false;
    }
  }

  Future<dynamic> findInDb(String email, String password) async {
    var response = await http.post(
      Uri.parse("${url}/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "senha": password}),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      token = data["token"];
      return data;
    } else {
      print('Erro: ${response.statusCode}');
      return null;
    }
  }

  Future<dynamic> requestToGetBarbershops() async {
    var data = await getUserData();
    String token = data!["token"];
    var response = await http.get(
      Uri.parse("${url}/barbearias/listar"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    print(jsonDecode(response.body));
  }

  Future<List<Map<String, dynamic>>> requestToGetBarber() async {
    var data = await getUserData();
    String token = data!["token"];
    var response = await http.get(
      Uri.parse("${url}/usuarios/barbeiros"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> decoded = jsonDecode(response.body);
      List<Map<String, dynamic>> barbers = decoded.cast<Map<String, dynamic>>();
      print(barbers);
      return barbers;
    }
    return [];
  }

  Future<void> MakeScheduling(
    String horario,
    String barbeiroNome,
    String clienteNome,
    String tipoServico,
    String endereco,
  ) async {
    var data = await getUserData();
    String token = data!["token"];
    var response = await http.post(
      Uri.parse("${url}/agendamentos/agendar"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "dataHorario": horario,
        "barbeiroNome": barbeiroNome,
        "clienteNome": clienteNome,
        "tipoServico": tipoServico,
        "endereco": endereco,
      }),
    );
    print(response.statusCode);
    print(jsonDecode(response.body));
  }



  

  Future<List<Map<String, dynamic>>> getAgendamentos() async {
    try {
      var data = await getUserData();
      String token = data!["token"];

      Dio dio = Dio();
      dio.options.headers["Content-Type"] = "application/json";
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get("${url}/agendamentos/meus-agendamentos");

      if (response.statusCode == 200) {
        List<dynamic> rawList = response.data;
        print(rawList);
        return rawList.cast<Map<String, dynamic>>();
      } else {
        print('Erro: ${response.statusCode}');
        throw Exception("Erro");
      }
    } catch (e) {
      print('Erro na requisição: $e');
      throw Exception("Erro");
    }
  }

  void saveInDb(dynamic user) async {
    var response = await http.post(
      Uri.parse("${url}/usuarios/cadastro"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user),
    );
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      print('Erro: ${response.statusCode}');
      return null;
    }
  }
}
