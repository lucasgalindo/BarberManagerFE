import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/repositories/user_repository.dart';

class BarberAutonomosViewModel {
  Future<List<Barberautonomos>> getBarberAutonomos() async {
    var result = await UserRepository.instance.requestToGetBarber();
    List<Barberautonomos> list = [];
    result.forEach((element){
      list.add(
        Barberautonomos.fromMap(element)
      );
    });
    return list;
  }
}
