import 'package:barbermanager_fe/models/abstractions/IUser.dart';

import 'barberservice.dart';

class Barberautonomos implements IUser{
  String name;
  String imageUrl;
  String description;
  double rating;
  String phone;
  String address;
  String cpf;
  @override
  String email;
  @override
  String password;

  Map<String, String>? workingHours;
  List<BarberService> services;
  String? token;

  Barberautonomos(
    this.email,
    this.password,
    this.name,
    this.imageUrl,
    this.description,
    this.rating,
    this.phone,
    this.address,
    this.workingHours,
    this.services,
    this.cpf,
    this.token,
  );

  factory Barberautonomos.fromMap(Map<dynamic, dynamic> map) {
    return Barberautonomos(
      map['email'] ?? '',
      map['password'] ?? '',
      map['name'] ?? '',
      map['imageUrl'] ?? '',
      map['description'] ?? '',
      (map['rating'] is double) ? map['rating'] : (map['rating'] ?? 0.0).toDouble(),
      map['phone'] ?? '',
      map['address'] ?? '',
      // workingHours: ensure it's a Map<String, String>
      (map['workingHours'] as Map?)?.map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      ) ?? <String, String>{},
      // services
      (map['services'] as List<dynamic>?)
          ?.map((service) => service is BarberService
              ? service
              : BarberService.fromMap(service as Map))
          .toList() ?? [],
      map["cpf"] ?? '',
      map["token"] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'rating': rating,
      'phone': phone,
      'address': address,
      'cpf': cpf,
      'token': token,
      'workingHours': workingHours,
      'services':
          services.map(
                (service) => {
                  'name': service.name,
                  'price': service.price,
                  'duration': service.duration,
                  'category': service.category,
                  'description': service.description,
                },
              )
              .toList(),
    };
  }
}
