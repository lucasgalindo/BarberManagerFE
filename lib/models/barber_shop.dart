import 'package:barbermanager_fe/models/barber.dart';

class BarberService {
  final String name;
  final double price;
  final String duration;
  final String category;
  final String description;

  BarberService({
    required this.name,
    required this.price,
    required this.duration,
    required this.category,
    required this.description,
  });
}

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
