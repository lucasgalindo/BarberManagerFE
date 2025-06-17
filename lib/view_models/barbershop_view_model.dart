import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/repositories/user_repository.dart';

class BarbershopViewModel {
  Future<List<Barbershop>> getBarbershops() async {
    final response = await UserRepository.instance.requestToGetBarbershops();
    // Supondo que response seja uma Future ou uma lista dinâmica
    // Se for Future, você deve tornar o método async e usar await
    // Aqui está a versão síncrona para exemplo:
    // if (response is List) {
    //   return response.map((item) => Barbershop.fromJson(item)).toList();
    // }
    return [];
  }
}
