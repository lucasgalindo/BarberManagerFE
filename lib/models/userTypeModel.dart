enum UserType {
  barbeiro(1),
  cliente(2),
  donoBarbearia(3);
  final int valor;

  const UserType(this.valor);
}

class UserTypeModel {
  final UserType userType;

  UserTypeModel({required this.userType});
}