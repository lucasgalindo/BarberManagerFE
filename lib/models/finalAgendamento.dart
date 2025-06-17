class FinalAgendamento {
  final int id;
  final DateTime dataHorario;
  final String barbeiroNome;
  final String clienteNome;
  final String tipoServico;
  final String endereco;
  final int price;

  FinalAgendamento({
    required this.id,
    required this.dataHorario,
    required this.barbeiroNome,
    required this.clienteNome,
    required this.tipoServico,
    required this.endereco,
    required this.price,
  });

  factory FinalAgendamento.fromJson(Map<String, dynamic> json) {
  return FinalAgendamento(
    id: json['id'],
    dataHorario: json['dataHorario'] != null ? DateTime.parse(json['dataHorario']) : DateTime.now(),
    barbeiroNome: json['barbeiroNome'] ?? '',
    clienteNome: json['clienteNome'] ?? '',
    tipoServico: json['tipoServico'] ?? '',
    endereco: json['endereco'] ?? '',
    price: json['price'] is int ? json['price'] : int.tryParse(json['price'].toString()) ?? 0,
  );
}

  Map<String, dynamic> toJson() {
    return {
      'dataHorario': dataHorario.toIso8601String(),
      'barbeiroNome': barbeiroNome,
      'clienteNome': clienteNome,
      'tipoServico': tipoServico,
      'endereco': endereco,
      'price': price,
    };
  }
}