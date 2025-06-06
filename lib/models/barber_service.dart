class BarberService {

  String name;
  double price;
  String duration;
  String category;
  String description;

  BarberService(
    this.name,
    this.price,
    this.duration,
    this.category,
    this.description,
  );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'duration': duration,
      'category': category,
      'description': description,
    };
  }
  factory BarberService.fromMap(Map<dynamic, dynamic> map) {
  return BarberService(
    map['name'],
    map['price'],
    map['duration'],
    map['category'],
    map['description'],
  );
}
}
