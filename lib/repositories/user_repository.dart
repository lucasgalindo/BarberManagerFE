class UserRepository {
  static final UserRepository _instance = UserRepository._internal();

  UserRepository._internal();

  static UserRepository get instance => _instance;

  List<Map<dynamic, dynamic>> db = [
    {
      "username": "Teste",
      "email": "teste@teste.com",
      "password": "teste123",
      "first_entry": true,
      "token": "sjiabsodasibdias.sdibashdbasi...",
      "preference": null,
      "type": 2
    },
  ];

  Map<dynamic, dynamic> findInDb(email, password, type) {
    return db.firstWhere(
      (item) =>
          item["email"].toString().toLowerCase() == email.toLowerCase() &&
          item["password"].toString() == password.toString() &&
          item["type"] == type,
      orElse: () => {},
    );
  }

  void updatePreference(preference, token) {
    db.firstWhere((item) => item["token"] == token)["preference"] = preference;
  }

  void saveInDb(username, email, password, token) {
    db.add({
      "username": username,
      "email": email,
      "password": password,
      "first_entry": true,
      "token": token,
      "preference": null,
    });
  }
}
