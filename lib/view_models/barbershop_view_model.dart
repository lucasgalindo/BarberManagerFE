import '../models/barber_shop.dart';

class BarbershopViewModel {
  List<Barbershop> getBarbershops() {
    return [
      Barbershop(
        name: 'Barbearia do Seu João',
        address: 'Avenida São Pedro, 123, Fundão, Recife - PE',
        rating: 4.5,
        phone: '(81)99900-2190',
        imageUrl: 'https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png',
      ),
      Barbershop(
        name: 'Jokers Barbers',
        address: 'Rua Pedro Jorge, 1423, Setubal, Recife - PE',
        rating: 4.7,
        phone: '(81)99420-2190',
        imageUrl: 'https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png',
      ),
    ];
  }
}
