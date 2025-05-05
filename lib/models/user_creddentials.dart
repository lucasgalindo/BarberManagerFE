import 'package:shared_preferences/shared_preferences.dart';

Future<void> setTypeUser(int type) async{
  final instance = await SharedPreferences.getInstance();
  instance.setInt("user_type", type);
}


Future<int?> getTypeUser() async{
  final instance = await SharedPreferences.getInstance();
  final result = instance.getInt("user_type");
  return result;
}