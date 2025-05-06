import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:barbermanager_fe/view_models/auth_provider.dart';
import 'package:barbermanager_fe/view_models/barbershop_view_model.dart';
import 'package:barbermanager_fe/widgets/barber_shop_card.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';
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
              drawer: Drawer(
                backgroundColor: Color.fromRGBO(30, 30, 30, 1),
                child: SafeArea(
                  child: Column(
                    children: [
                      DrawerHeader(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color.fromRGBO(23, 23, 180, 1),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.swap_horiz,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Procurar por Barbeiros', // Quando tiver na tela de Barbeiros, colocar uma logica para mudar o texto do botao
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                // Colocar lógica para trocar o tipo de busca
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Favoritos',
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.smart_toy_outlined,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'ChatBot',
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                // Abrir o chatbot com IA que iremos fazer.
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.white24),
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                        ),
                        title: const Text(
                          'Sair',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onTap: () {
                          authViewModel.logout(context);
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

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
                        return BarbershopCard(shop: barbershops[index]);
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
        selected,
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
