import 'package:barbermanager_fe/views/Initalscreen.dart';
import 'package:barbermanager_fe/views/Loginscreen.dart';
import 'package:barbermanager_fe/views/registerPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      routes: {
        "/": (context) => Initialscreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterPage(),
      },
    );
  }
}
