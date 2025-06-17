import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:barbermanager_fe/widgets/barber_drawer.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';
import 'package:barbermanager_fe/widgets/dashboard_screen.dart';
import 'package:barbermanager_fe/widgets/service_category_manager.dart';
import 'package:flutter/material.dart';

class BarberScreen extends StatefulWidget {
  final String username;
  const BarberScreen({super.key, required this.username});

  @override
  State<BarberScreen> createState() => _BarberScreenState();
}

class _BarberScreenState extends State<BarberScreen> {
  String? selectedCategory;
  bool removeServiceState = false;
  bool removeState = false;
  Barberautonomos? barberAutonomo;
  String? _imageUrl;

  final List<Map<String, dynamic>> services = [
    {
      'name': 'Corte Masculino',
      'description': 'Corte tradicional masculino.',
      'price': 30.0,
      'category': 'Corte',
    },
    {
      'name': 'Barba Completa',
      'description': 'Barba feita com navalha.',
      'price': 25.0,
      'category': 'Barba',
    },
  ];

  List<BarberService> get filteredServices {
    if (barberAutonomo == null) return [];
    return barberAutonomo!.categories
        .expand((category) => category.services.where(
            (service) => selectedCategory == null || service.name == selectedCategory))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final userData = await getUserData();
    if (userData != null) {
      setState(() {
        barberAutonomo = Barberautonomos.fromMap(userData);
        print(barberAutonomo!.categories.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted || barberAutonomo == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return DashboardCalendar(isBarbershopOwner: true);
  }
}
