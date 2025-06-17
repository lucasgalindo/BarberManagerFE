import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:barbermanager_fe/view_models/BarberAutonomosViewModel.dart';
import 'package:barbermanager_fe/views/barber_autonomo_details_view.dart';
import 'package:barbermanager_fe/widgets/BarberAutonomoCard.dart';
import 'package:barbermanager_fe/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';
import 'package:barbermanager_fe/models/barberAutonomos.dart';

class BarberView extends StatefulWidget {
  const BarberView({super.key});

  @override
  State<BarberView> createState() => _BarberViewState();
}

class _BarberViewState extends State<BarberView> {
  String username = "...";
  String? selectedFilter;

  final viewModel = BarberAutonomosViewModel();
  final List<String> filters = [
    "Melhores Avaliados",
    "Mais Próximos",
    "Mais Experientes",
  ];

  @override
  void initState() {
    _loadUserName();
    super.initState();
  }

  List<Barberautonomos> barbers = [];
  Future<void> _loadUserName() async {
    final userData = await getUserData();
    if (userData != null && userData['usuario'] != null) {
      setState(() {
        username = userData['usuario']['nome'];
      });
    }
    var data = await viewModel.getBarberAutonomos();
    setState(() {
      barbers = data;
    });
  }


  @override
  Widget build(BuildContext context) {

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
              itemCount: barbers.length,
              itemBuilder: (context, index) {
                final barber = barbers[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                BarberAutonomoDetailsView(barber: barber),
                      ),
                    );
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
