class Customer {
  String? token;
  Usuario? usuario;

  Customer({this.token, this.usuario});

  Customer.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    usuario =
        json['usuario'] != null ? new Usuario.fromJson(json['usuario']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.usuario != null) {
      data['usuario'] = this.usuario!.toJson();
    }
    return data;
  }
}

class Usuario {
  String? nome;
  String? email;
  String? endereco;
  String? tipo;

  Usuario(
      {this.nome,
      this.email,
      this.endereco,
      this.tipo,});

  Usuario.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    endereco = json['endereco'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = nome;
    data['email'] = email;
    data['endereco'] = endereco;
    data['tipo'] = tipo;
    return data;
  }
}
