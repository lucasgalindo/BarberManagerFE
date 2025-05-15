import 'package:barbermanager_fe/models/barberAutonomos.dart';

class BarberAutonomosViewModel {
  List<Barberautonomos> getBarberAutonomos() {
    return [
      Barberautonomos(
        id: "1",
        name: "João Barbeiro",
        imageUrl:
            "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
        description: "Especialista em cortes modernos.",
        rating: 4.8,
        phone: "(11) 99999-9999",
        address: "Rua dos Barbeiros, 123",
      ),
      Barberautonomos(
        id: "2",
        name: "Carlos Estilo",
        imageUrl:
            "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
        description: "Cortes clássicos e modernos.",
        rating: 3.2,
        phone: "(21) 88888-8888",
        address: "Avenida dos Estilos, 456",
      ),
      Barberautonomos(
        id: "3",
        name: "Lucas Almeida",
        imageUrl:
            "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
        description: "Especialista em cortes premium.",
        rating: 4.9,
        phone: "(31) 77777-7777",
        address: "Praça dos Cabelos, 789",
      ),
    ];
  }
}
