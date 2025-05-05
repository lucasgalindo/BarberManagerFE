import 'package:barbermanager_fe/models/jwt.dart';
import 'package:flutter/material.dart';

class EmbeddedPublicScreen extends StatelessWidget {
  final Widget child;

  const EmbeddedPublicScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data != null) {
          // Já está logado → redireciona para a home
          Future.microtask(() {
             Navigator.of(context).pushReplacementNamed('/home');
          });
          return const SizedBox();
        }

        return child; 
      },
    );
  }
}