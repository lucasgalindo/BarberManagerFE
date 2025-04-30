import 'package:barbermanager_fe/view_models/AuthProvider.dart';
import 'package:barbermanager_fe/views/Initalscreen.dart';
import 'package:barbermanager_fe/views/Loginscreen.dart';
import 'package:barbermanager_fe/views/SeekServicescreen.dart';
import 'package:barbermanager_fe/views/protected/firstEntryLogin.dart';
import 'package:barbermanager_fe/views/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AuthProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Poppins"),
      routes: {
        "/": (context) => Initialscreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterPage(),
        "/first_entry": (context) => FirstEntryLogin(),
        "/seekservice": (context) => Seekservicescreen(),
      },
    );
  }
}
