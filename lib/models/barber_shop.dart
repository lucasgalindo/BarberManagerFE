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
  // factory Barbershop.fromJson(Map<String, dynamic> json) {
  //   return Barbershop(
  //     name: json['name'] as String,
  //     address: json['address'] as String,
  //     rating: (json['rating'] as num).toDouble(),
  //     phone: json['phone'] as String,
  //     imageUrl: json['imageUrl'] as String,
  //     workingHours: Map<String, String>.from(json['workingHours'] as Map),
  //     description: json['description'] as String,
  //     categories: List<String>.from(json['categories'] as List),
  //     services: (json['services'] as List)
  //         .map((e) => BarberService.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  //     team: (json['team'] as List)
  //         .map((e) => Barber.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  //   );
  // }
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
