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
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(username),
              accountEmail: const Text('Barbeiro'),
              currentAccountPicture: imageUrl != null
                  ? CircleAvatar(backgroundImage: NetworkImage(imageUrl!))
                  : const CircleAvatar(child: Icon(Icons.person, size: 36)),
            ),
            ListTile(
              leading: const Icon(Icons.design_services),
              title: const Text('Meus Serviços'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Gerenciar Categorias'),
              onTap: onManageCategories,
            ),
            ListTile(
              leading: const Icon(Icons.build),
              title: const Text('Gerenciar Serviços'),
              onTap: onManageServices,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: onLogout,
            ),
          ],
        ),
      ),
    );
  }
}