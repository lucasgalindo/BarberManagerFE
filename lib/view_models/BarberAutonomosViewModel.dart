import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/models/barberservice.dart';

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
        workingHours: {
          "Seg": "09:00 - 19:00",
          "Ter": "09:00 - 19:00",
          "Qua": "09:00 - 19:00",
          "Qui": "09:00 - 19:00",
          "Sex": "09:00 - 19:00",
          "Sáb": "10:00 - 16:00",
          "Dom": "Fechado",
        },
        services: [
          BarberService(
            name: "Corte Masculino",
            price: 40.0,
            duration: "30min",
            category: "Corte",
            description: "Corte de cabelo masculino moderno.",
          ),
          BarberService(
            name: "Barba",
            price: 25.0,
            duration: "20min",
            category: "Barba",
            description: "Barba feita com navalha.",
          ),
        ],
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
        workingHours: {
          "Seg": "Fechado",
          "Ter": "10:00 - 18:00",
          "Qua": "10:00 - 18:00",
          "Qui": "10:00 - 18:00",
          "Sex": "10:00 - 18:00",
          "Sáb": "10:00 - 14:00",
          "Dom": "Fechado",
        },
        services: [
          BarberService(
            name: "Corte Social",
            price: 35.0,
            duration: "30min",
            category: "Corte",
            description: "Corte social clássico.",
          ),
          BarberService(
            name: "Sobrancelha",
            price: 15.0,
            duration: "10min",
            category: "Sobrancelha",
            description: "Design de sobrancelha.",
          ),
        ],
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
        workingHours: {
          "Seg": "08:00 - 20:00",
          "Ter": "08:00 - 20:00",
          "Qua": "08:00 - 20:00",
          "Qui": "08:00 - 20:00",
          "Sex": "08:00 - 20:00",
          "Sáb": "09:00 - 15:00",
          "Dom": "Fechado",
        },
        services: [
          BarberService(
            name: "Corte Premium",
            price: 60.0,
            duration: "45min",
            category: "Corte",
            description: "Corte premium com finalização.",
          ),
          BarberService(
            name: "Barba Completa",
            price: 35.0,
            duration: "25min",
            category: "Barba",
            description: "Barba completa com toalha quente.",
          ),
        ],
      ),
    ];
  }
}
