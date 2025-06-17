import 'barberservice.dart';

class Barberautonomos {
  int id;
  String name;
  String email;
  String password;
  String address;
  String type;
  List<Map<String, dynamic>> barbershops;
  Map<String, dynamic>? barbershop;
  List<Category> categories;

  Barberautonomos(
    this.id,
    this.name,
    this.email,
    this.password,
    this.address,
    this.type,
    this.barbershops,
    this.barbershop,
    this.categories,
  );

  factory Barberautonomos.fromMap(Map<dynamic, dynamic> map) {
    return Barberautonomos(
      map['id'] ?? 0,
      map['nome'] ?? '',
      map['email'] ?? '',
      map['senha'] ?? '',
      map['endereco'] ?? '',
      map['tipo'] ?? '',
      (map['barbearias'] as List?)?.map((item) => item as Map<String, dynamic>).toList() ?? [],
      map['barbearia'] as Map<String, dynamic>?,
      (map['categoria'] as List?)?.map((item) => Category.fromMap(item as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'email': email,
      'senha': password,
      'endereco': address,
      'tipo': type,
      'barbearias': barbershops,
      'barbearia': barbershop,
      'categoria': categories.map((category) => category.toMap()).toList(),
    };
  }
}

class Category {
  int id;
  String name;
  String description;
  List<BarberService> services;

  Category(
    this.id,
    this.name,
    this.description,
    this.services,
  );

  factory Category.fromMap(Map<dynamic, dynamic> map) {
    return Category(
      map['id'] ?? 0,
      map['nome'] ?? '',
      map['descricao'] ?? '',
      (map['servico'] as List?)?.map((item) => BarberService.fromMap(item as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'descricao': description,
      'servico': services.map((service) => service.toMap()).toList(),
    };
  }
}