import 'barberservice.dart';

class Barberautonomos {
  final String id;
  final String name;
  final String? imageUrl;
  final String? description;
  final double? rating;
  final String? phone;
  final String? address;
  final Map<String, String>? workingHours;
  final List<BarberService>? services;

  Barberautonomos({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
    this.rating,
    this.phone,
    this.address,
    this.workingHours,
    this.services,
  });

  factory Barberautonomos.fromMap(Map<String, dynamic> map) {
    return Barberautonomos(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'],
      description: map['description'],
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      phone: map['phone'],
      address: map['address'],
      workingHours: map['workingHours'],
      services:
          map['services'] != null
              ? List<Map<String, dynamic>>.from(map['services'])
                  .map(
                    (serviceMap) => BarberService(
                      name: serviceMap['name'] ?? '',
                      price: (serviceMap['price'] as num?)?.toDouble() ?? 0.0,
                      duration: serviceMap['duration'] ?? '',
                      category: serviceMap['category'] ?? '',
                      description: serviceMap['description'] ?? '',
                    ),
                  )
                  .toList()
              : null,
    );
  }
}
