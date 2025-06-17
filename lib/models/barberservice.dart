class BarberService {
  int id;
  String name;
  String description;
  double price;

  BarberService({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory BarberService.fromMap(Map<dynamic, dynamic> map) {
    return BarberService(
      id: map['id'] ?? 0,
      name: map['title'] ?? map['name'] ?? '',
      description: map['descricao'] ?? map['description'] ?? '',
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : (map['price'] is double)
              ? map['price']
              : double.tryParse(map['price']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}