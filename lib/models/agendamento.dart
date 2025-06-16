import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/models/customer.dart';

class Agendamento {
  final DateTime dateTime;
  final Barbershop? barbershop;
  final Barber barber;
  final Customer cliente;
  final BarberService servico;
  final double preco;

  Agendamento({
    required this.dateTime,
    this.barbershop,
    required this.barber,
    required this.cliente,
    required this.servico,
    required this.preco,
  });

  factory Agendamento.fromJson(Map<String, dynamic> json) {
    return Agendamento(
      dateTime: DateTime.parse(json['dateTime']),
      barbershop: json['barbershop'],
      barber: json['barber'],
      cliente: json['cliente'],
      servico: json['servico'],
      preco: (json['preco'] as num).toDouble(),
    );
  }
}
