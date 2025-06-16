class BarberService {
  String name;
  double price;
  String category;
  String description;

  BarberService(
    this.name,
    this.price,
    this.category,
    this.description,
  );


  factory BarberService.fromMap(Map<dynamic, dynamic> map) {
    return BarberService(
      map['name'],
      map['price'],
      map['category'],
      map['description'],
    );
  }
}
