import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/widgets/barber_shop_card.dart';
import 'package:flutter/material.dart';

class CardType {
    late Barbershop barbershop;
    late List<Barber> team;
    late BarberService selectedService;
    late Map<String, String> workingHours;
    CardType(
      this.barbershop, this.selectedService, this.team, this.workingHours
    );
}


class ClientHandleService {
  // Instância privada estática
  static final ClientHandleService _instance = ClientHandleService._internal();

  // Lista de escolhas
  List<CardType> choices = [];

  // Construtor privado
  ClientHandleService._internal();

  // Fábrica que retorna sempre a mesma instância
  factory ClientHandleService() {
    return _instance;
  }

  void add(
    Barbershop barbershop,
    List<Barber> team,
    BarberService selectedService,
    Map<String, String> workingHours,
  ) {
    choices.add(
      CardType(
        barbershop,
        selectedService,
        team,
        workingHours
      )
    );
  }
}
