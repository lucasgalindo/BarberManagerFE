import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/view_models/auth_provider.dart';
import 'package:barbermanager_fe/view_models/barbershop_view_model.dart';
import 'package:barbermanager_fe/views/barbershop_details_view.dart';
import 'package:barbermanager_fe/widgets/barber_shop_card.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';
import 'package:barbermanager_fe/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientScreen extends StatefulWidget {
  final String username;
  const ClientScreen({super.key, required this.username});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  String? selectedFilter;
  final viewModel = BarbershopViewModel();
  List<Barbershop> barbershops = [];

  final List<String> filters = [
    "Mais Próximas",
    "Melhores Avaliadas",
    "Mais Serviços",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  void fetch() async{
      barbershops = await viewModel.getBarbershops();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder:
            (context, authViewModel, _) => Scaffold(
              appBar: AppBar(),
              drawer: CustomDrawer(username: widget.username),
              body: Stack(
                children: [
                  Column(
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
                                        (context) => BarbershopDetailsView(
                                          barbershop: shop,
                                        ),
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
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/chat');
                      },
                      fillColor: const Color.fromARGB(255, 33, 33, 33),
                      constraints: BoxConstraints(minWidth: 0.0),
                      shape: CircleBorder(),
                      elevation: 2.0,
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.chat, size: 40, color: Colors.white),
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
