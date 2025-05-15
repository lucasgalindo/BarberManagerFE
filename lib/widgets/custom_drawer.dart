import 'package:barbermanager_fe/view_models/auth_provider.dart';
import 'package:barbermanager_fe/views/protected/barberView.dart';
import 'package:barbermanager_fe/views/protected/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final String username;

  const CustomDrawer({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthProvider>(context, listen: false);

    return Drawer(
      backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
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
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromRGBO(23, 23, 180, 1),
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.swap_horiz, color: Colors.white),
                    title: Text(
                      ModalRoute.of(context)?.settings.name == '/home'
                          ? 'Procurar por Barbeiros'
                          : 'Procurar por Barbearias',
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      if (ModalRoute.of(context)?.settings.name == '/home') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            settings: const RouteSettings(name: '/barber'),
                            builder: (context) => const BarberView(),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            settings: const RouteSettings(name: '/home'),
                            builder: (context) => const HomeView(),
                          ),
                        );
                      }
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
                      // Abrir o chatbot com IA
                    },
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
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
    );
  }
}
