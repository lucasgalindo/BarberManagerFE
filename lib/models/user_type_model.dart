enum UserType {
  barbeiro(1),
  cliente(2),
  donoBarbearia(3);
  final int valor;
  const UserType(this.valor);
  static UserType? fromInt(int value) {
    return UserType.values.firstWhere(
      (e) => e.valor == value,
      orElse: () => UserType.cliente,
    );
  }
}

class UserTypeModel {
  final UserType userType;

  UserTypeModel({required this.userType});
}