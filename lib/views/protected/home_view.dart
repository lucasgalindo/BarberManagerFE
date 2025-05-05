import 'package:barbermanager_fe/view_models/auth_provider.dart';
import 'package:barbermanager_fe/view_models/barbershop_view_model.dart';
import 'package:barbermanager_fe/widgets/barber_shop_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeView extends StatelessWidget {
  const HomeView([
    Key? key,
  ]): super(key: key);



  @override
  Widget build(BuildContext context) {
    final viewModel = BarbershopViewModel();
    final barbershops = viewModel.getBarbershops();
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, viewModel, _) => Scaffold(
      
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text('Drawer Header'),
      ),
      ListTile(
        title: const Text('Logout'),
        onTap: () {
          viewModel.logout(context);
        },
      ),
      ListTile(
        title: const Text('Item 2'),
        onTap: () {
          
        },
      ),
      ]
      ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilter("Mais Próximas"),
                _buildFilter("Melhores Avaliadas", selected: true),
                _buildFilter("Mais Serviços"),
              ],
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
    )

      ),
    );
  }
  Widget _buildFilter(String title, {bool selected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Colors.blueAccent : const Color(0xFF2A2A2A),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {},
        child: Text(title),
      ),
    );
}

}