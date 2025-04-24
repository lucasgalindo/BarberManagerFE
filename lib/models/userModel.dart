class UserModel {
  String username;
  String email;
  String phone;
  String birthDate;
  String password;
  String confirmPassword;

  UserModel({
    this.username = '',
    this.email = '',
    this.phone = '',
    this.birthDate = '',
    this.password = '',
    this.confirmPassword = '',
  });
}
