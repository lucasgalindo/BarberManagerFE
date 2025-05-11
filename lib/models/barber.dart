class Barber {
  final String name;
  final String imageUrl;
  final String description;
  final List<String> services; // Serviços que o barbeiro realiza
  final List<String> availableTimes; // Horários disponíveis para o barbeiro
  final List<String> reservedTimes; // Horários já reservados

  Barber({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.services,
    required this.availableTimes,
    this.reservedTimes = const [], // Inicializa como vazio por padrão
  });
}
