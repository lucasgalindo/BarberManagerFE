import '../models/barber_shop.dart';

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
        workingHours: {"Segunda": "09:00 - 18:00", "Terça": "09:00 - 18:00"},
        description: "Uma barbearia tradicional com atendimento de qualidade.",
        categories: ["Corte", "Barba", "Coloração"],
        services: [
          BarberService(
            name: "Corte Masculino",
            price: 30.0,
            duration: "30 min",
            category: "Corte",
            description: "Um corte clássico e moderno para homens.",
          ),
          BarberService(
            name: "Barba",
            price: 20.0,
            duration: "20 min",
            category: "Barba",
            description: "Aparação e modelagem da barba com perfeição.",
          ),
          BarberService(
            name: "Coloração",
            price: 50.0,
            duration: "45 min",
            category: "Coloração",
            description: "Coloração capilar para um visual renovado.",
          ),
          BarberService(
            name: "Coloração",
            price: 50.0,
            duration: "45 min",
            category: "Coloração",
            description: "Coloração capilar para um visual renovado.",
          ),
          BarberService(
            name: "Coloração",
            price: 50.0,
            duration: "45 min",
            category: "Coloração",
            description: "Coloração capilar para um visual renovado.",
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
        workingHours: {"Segunda": "10:00 - 19:00", "Terça": "10:00 - 19:00"},
        description: "Barbearia moderna com serviços premium.",
        categories: ["Corte", "Barba", "Relaxamento"],
        services: [
          BarberService(
            name: "Corte Premium",
            price: 40.0,
            duration: "40 min",
            category: "Corte",
            description: "Corte premium com técnicas avançadas.",
          ),
          BarberService(
            name: "Barba Completa",
            price: 25.0,
            duration: "25 min",
            category: "Barba",
            description: "Barba completa com toalha quente e finalização.",
          ),
          BarberService(
            name: "Relaxamento Capilar",
            price: 60.0,
            duration: "60 min",
            category: "Relaxamento",
            description: "Relaxamento capilar para cabelos volumosos.",
          ),
        ],
      ),
    ];
  }
}
