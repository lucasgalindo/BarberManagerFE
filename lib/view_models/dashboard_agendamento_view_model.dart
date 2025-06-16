import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:barbermanager_fe/models/agendamento.dart';
import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/models/customer.dart';
import 'package:barbermanager_fe/repositories/user_repository.dart';

/// ViewModel para buscar e fornecer agendamentos prontos para o dashboard,
/// independente se são de barbearia ou barbeiro autônomo.
class DashboardAgendamentoViewModel extends ChangeNotifier {
  final bool isBarbershopOwner;
  final String userToken;
  // pode ser o id do barbeiro ou da barbearia, conforme o login

  DashboardAgendamentoViewModel({
    required this.isBarbershopOwner,
    required this.userToken,
  });

  List<Agendamento> _agendamentos = [];
  bool _loading = false;
  String? _error;

  List<Agendamento> get agendamentos => _agendamentos;
  bool get loading => _loading;
  String? get error => _error;

  /// Chame este método para buscar os agendamentos do backend
  Future<void> fetchAgendamentos() async {
    _loading = true;
    _error = null;
    notifyListeners();

    print(userToken);

    final url =
        'https://barbermanager-preview.onrender.com/agendamentos/meus-agendamentos';
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer ${userToken.toString()}"},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      _agendamentos = data.map((json) => Agendamento.fromJson(json)).toList();
      _loading = false;
      notifyListeners();
    } else {
      _error = "Erro ao buscar agendamentos: ${response.statusCode}";
      _loading = false;
      notifyListeners();
    }
  }
}
