import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:barbermanager_fe/view_models/BarberAutonomosViewModel.dart';
import 'package:barbermanager_fe/widgets/BarberAutonomoCard.dart';
import 'package:barbermanager_fe/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';

class BarberView extends StatefulWidget {
  const BarberView({super.key});

  @override
  State<BarberView> createState() => _BarberViewState();
}

class _BarberViewState extends State<BarberView> {
  String username = "...";
  String? selectedFilter;

  final List<String> filters = [
    "Melhores Avaliados",
    "Mais Próximos",
    "Mais Experientes",
  ];

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final userData = await getUserData();
    if (userData != null && userData['username'] != null) {
      setState(() {
        username = userData['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = BarberAutonomosViewModel();
    final barbers = viewModel.getBarberAutonomos();

    final filteredBarbers =
        selectedFilter == null
            ? barbers
            : barbers.where((barber) {
              if (selectedFilter == "Melhores Avaliados") {
                return barber.rating >= 4.5;
              } else if (selectedFilter == "Mais Próximos") {
                return barber.address.contains("Rua");
              } else if (selectedFilter == "Mais Experientes") {
                return barber.description.contains("Experiência");
              }
              return true;
            }).toList();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      drawer: CustomDrawer(username: username),
      body: Column(
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: BoxOfCarousel(
                    isSelected: filter == selectedFilter,
                    child: Center(
                      child: Text(
                        filter,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBarbers.length,
              itemBuilder: (context, index) {
                final barber = filteredBarbers[index];
                return GestureDetector(
                  onTap: () {
                    // Lógica para navegar para a tela de detalhes do barbeiro
                  },
                  child: BarberAutonomoCard(barber: barber),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
