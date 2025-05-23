import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barberservice.dart';

class Barbershop {
  final String name;
  final String address;
  final double rating;
  final String phone;
  final String imageUrl;
  final Map<String, String> workingHours;
  final String description;
  final List<String> categories;
  final List<BarberService> services;
  final List<Barber> team;

  Barbershop({
    required this.name,
    required this.address,
    required this.rating,
    required this.phone,
    required this.imageUrl,
    required this.workingHours,
    required this.description,
    required this.categories,
    required this.services,
    required this.team,
  });
}
