import 'package:barbermanager_fe/view_models/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmbeddedProtectedScreen extends StatelessWidget {
  final Widget child;

  const EmbeddedProtectedScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (!auth.isLoggedIn) {
      Future.microtask(() {
        Navigator.of(context).pushReplacementNamed('/login');
      });
      return const SizedBox(); // Tela vazia enquanto redireciona
    }

    return child;
  }
}
