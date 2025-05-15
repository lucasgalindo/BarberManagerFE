import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:barbermanager_fe/view_models/auth_provider.dart';
import 'package:barbermanager_fe/view_models/barbershop_view_model.dart';
import 'package:barbermanager_fe/views/barbershop_details_view.dart.dart';
import 'package:barbermanager_fe/widgets/barber_shop_card.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';
import 'package:barbermanager_fe/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? selectedFilter;
  String username = "...";

  final List<String> filters = [
    "Mais Próximas",
    "Melhores Avaliadas",
    "Mais Serviços",
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
    final viewModel = BarbershopViewModel();
    final barbershops = viewModel.getBarbershops();

    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder:
            (context, authViewModel, _) => Scaffold(
              appBar: AppBar(),
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
                        return _buildFilter(
                          filter,
                          selected: filter == selectedFilter,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: barbershops.length,
                      itemBuilder: (context, index) {
                        final shop = barbershops[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        BarbershopDetailsView(barbershop: shop),
                              ),
                            );
                          },
                          child: BarbershopCard(shop: shop),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget _buildFilter(String title, {required bool selected}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: BoxOfCarousel(
        isSelected: selected,
        child: Center(
          child: Text(title, style: const TextStyle(color: Colors.white)),
        ),
        onTap: () {
          setState(() {
            selectedFilter = title;
          });
        },
      ),
    );
  }
}
