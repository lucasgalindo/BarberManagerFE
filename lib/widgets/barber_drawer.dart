import 'package:flutter/material.dart';

class BarberDrawer extends StatelessWidget {
  final String username;
  final String? imageUrl;
  final VoidCallback? onManageCategories;
  final VoidCallback? onManageServices;
  final VoidCallback? onLogout;

  const BarberDrawer({
    super.key,
    required this.username,
    this.imageUrl,
    this.onManageCategories,
    this.onManageServices,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
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
                    imageUrl != null
                        ? CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(imageUrl!),
                          backgroundColor: const Color.fromRGBO(23, 23, 180, 1),
                        )
                        : const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color.fromRGBO(23, 23, 180, 1),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
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
                    const SizedBox(height: 4),
                    const Text(
                      'Barbeiro',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
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
                    leading: const Icon(Icons.build, color: Colors.white),
                    title: const Text(
                      'Gerenciar Serviços',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: onManageServices,
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
              onTap: onLogout,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
