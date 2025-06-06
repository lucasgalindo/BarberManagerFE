class BarberService {
  final String name;
  final double price;
  final String duration;
  final String category;
  final String description;

  BarberService(
    this.name,
    this.price,
    this.duration,
    this.category,
    this.description,
  );

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
