class UserRepository {
  static final UserRepository _instance = UserRepository._internal();

  UserRepository._internal();

  static UserRepository get instance => _instance;

  List<Map<dynamic, dynamic>> db = [
    {
      "username": "Teste",
      "email": "teste@gmail.com",
      "password": "123123An",
      "first_entry": true,
      "token": "sjiabsodasibdias.sdibashdbasi...",
      "preference": null,
    },
  ];

  Map<dynamic, dynamic> findInDb(email, password) {
    return db.firstWhere(
      (item) =>
          item["email"].toString().toLowerCase() == email.toLowerCase() &&
          item["password"].toString() == password.toString(),
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
