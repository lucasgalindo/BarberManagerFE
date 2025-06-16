import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/models/barberservice.dart';

class BarbershopViewModel {
  List<Barbershop> getBarbershops() {
    return [
      Barbershop(
        name: 'Barbearia do Seu João',
        address: 'Avenida São Pedro, 123, Fundão, Recife - PE',
        rating: 4.5,
        phone: '(81)99900-2190',
        imageUrl:
            'https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png',
        workingHours: {
          "Segunda": "09:00 - 18:00",
          "Terça": "09:00 - 18:00",
          "Quarta": "09:00 - 18:00",
          "Quinta": "09:00 - 18:00",
          "Sexta": "09:00 - 18:00",
          "Sábado": "09:00 - 14:00",
          "Domingo": "Fechado",
        },
        description: "Uma barbearia tradicional com atendimento de qualidade.",
        categories: ["Corte", "Barba", "Coloração"],
        services: [
          BarberService(
            "Corte Masculino",
            30.0,
            "Corte",
            "Um corte clássico e moderno para homens.",
          ),
          BarberService(
            "Barba",
            20.0,
            "Barba",
            "Aparação e modelagem da barba com perfeição.",
          ),
          BarberService(
            "Coloração",
            50.0,
            "Coloração",
            "Coloração capilar para um visual renovado.",
          ),
        ],
        team: [
          Barber(
            name: "João Silva",
            imageUrl:
                "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
            description: "Ótimo barbeiro com experiência em cortes modernos.",
            services: ["Corte Masculino", "Barba"],
            availableTimes: ["09:00", "10:00", "11:00", "14:00", "15:00"],
            reservedTimes: ["10:00"], // Exemplo de horário reservado
          ),
          Barber(
            name: "Carlos Souza",
            imageUrl:
                "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
            description: "Ótimo barbeiro com experiência em coloração.",
            services: ["Coloração", "Barba"],
            availableTimes: ["10:00", "11:00", "13:00", "16:00"],
            reservedTimes: ["13:00"], // Exemplo de horário reservado
          ),
        ],
      ),
      Barbershop(
        name: 'Jokers Barbers',
        address: 'Rua Pedro Jorge, 1423, Setubal, Recife - PE',
        rating: 4.7,
        phone: '(81)99420-2190',
        imageUrl:
            'https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png',
        workingHours: {
          "Segunda": "10:00 - 19:00",
          "Terça": "10:00 - 19:00",
          "Quarta": "10:00 - 19:00",
          "Quinta": "10:00 - 19:00",
          "Sexta": "10:00 - 19:00",
          "Sábado": "09:00 - 15:00",
          "Domingo": "Fechado",
        },
        description: "Barbearia moderna com serviços premium.",
        categories: ["Corte", "Barba", "Relaxamento"],
        services: [
          BarberService(
            "Corte Premium",
            40.0,
            "Corte",
            "Corte premium com técnicas avançadas.",
          ),
          BarberService(
            "Barba Completa",
            25.0,
            "Barba",
            "Barba completa com toalha quente e finalização.",
          ),
          BarberService(
            "Relaxamento Capilar",
            60.0,
            "Relaxamento",
            "Relaxamento capilar para cabelos volumosos.",
          ),
        ],
        team: [
          Barber(
            name: "Lucas Almeida",
            imageUrl:
                "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
            description: "Ótimo barbeiro com experiência em cortes modernos.",
            services: ["Corte Premium", "Relaxamento Capilar"],
            availableTimes: ["10:00", "11:30", "14:00", "16:00"],
            reservedTimes: ["11:30"], // Exemplo de horário reservado
          ),
          Barber(
            name: "Ricardo Lima",
            imageUrl:
                "https://res.cloudinary.com/dnnhfgiu5/image/upload/v1746150345/ddraiux7htox7tqi1lot.png",
            description: "Ótimo barbeiro com experiência em cortes modernos.",
            services: ["Barba Completa", "Relaxamento Capilar"],
            availableTimes: ["09:30", "11:00", "13:30", "15:30"],
            reservedTimes: ["15:30"], // Exemplo de horário reservado
          ),
        ],
      ),
    ];
  }
}
