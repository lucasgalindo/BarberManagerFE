import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/models/barberservice.dart';

class BarberAutonomosViewModel {
  List<Barberautonomos> getBarberAutonomos() {
    return [
      Barberautonomos.fromMap({
        "id": "1",
        "name": "João Barbeiro",
        "imageUrl":
            "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
        "description": "Especialista em cortes modernos.",
        "rating": 4.8,
        "phone": "(11) 99999-9999",
        "address": "Rua dos Barbeiros, 123",
        "workingHours": {
          "Seg": "09:00 - 19:00",
          "Ter": "09:00 - 19:00",
          "Qua": "09:00 - 19:00",
          "Qui": "09:00 - 19:00",
          "Sex": "09:00 - 19:00",
          "Sáb": "10:00 - 16:00",
          "Dom": "Fechado",
        },
        "services": [
          BarberService(
            "Corte Masculino",
            40.0,
            "30min",
            "Corte",
            "Corte de cabelo masculino moderno.",
          ),
          BarberService(
            "Barba",
            25.0,
            "20min",
            "Barba",
            "Barba feita com navalha.",
          ),
        ],
      }),
      Barberautonomos.fromMap(
        {
          "id": "2",
        "name": "Carlos Estilo",
        "imageUrl":
            "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
        "description": "Cortes clássicos e modernos.",
        "rating": 3.2,
        "phone": "(21) 88888-8888",
        "address": "Avenida dos Estilos, 456",
        "workingHours": {
          "Seg": "Fechado",
          "Ter": "10:00 - 18:00",
          "Qua": "10:00 - 18:00",
          "Qui": "10:00 - 18:00",
          "Sex": "10:00 - 18:00",
          "Sáb": "10:00 - 14:00",
          "Dom": "Fechado",
        },
        "services": [
          BarberService(
            "Corte Social",
            35.0,
            "30min",
            "Corte",
            "Corte social clássico.",
          ),
          BarberService(
            "Sobrancelha",
            15.0,
            "10min",
            "Sobrancelha",
            "Design de sobrancelha.",
          ),
        ],
        }
      ),
      Barberautonomos.fromMap(
        {
          "id": "3",
        "name": "Lucas Almeida",
        "imageUrl":
            "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
        "description": "Especialista em cortes premium.",
        "rating": 4.9,
        "phone": "(31) 77777-7777",
        "address": "Praça dos Cabelos, 789",
        "workingHours": {
          "Seg": "08:00 - 20:00",
          "Ter": "08:00 - 20:00",
          "Qua": "08:00 - 20:00",
          "Qui": "08:00 - 20:00",
          "Sex": "08:00 - 20:00",
          "Sáb": "09:00 - 15:00",
          "Dom": "Fechado",
        },
        "services": [
          BarberService(
            "Corte Premium",
            60.0,
            "45min",
            "Corte",
            "Corte premium com finalização.",
          ),
          BarberService(
            "Barba Completa",
            35.0,
            "25min",
            "Barba",
            "Barba completa com toalha quente.",
          ),
        ],
        }
      ),
    ];
  }
}
