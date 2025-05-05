import 'package:barbermanager_fe/view_models/auth_provider.dart';
import 'package:barbermanager_fe/views/initial_screen.dart';
import 'package:barbermanager_fe/views/login_screen.dart';
import 'package:barbermanager_fe/views/embedded_protected_screendart';
import 'package:barbermanager_fe/views/embedded_public_screen.dart';
import 'package:barbermanager_fe/views/protected/first_entry_login.dart';
import 'package:barbermanager_fe/views/protected/home_view.dart';
import 'package:barbermanager_fe/views/register_page.dart';
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
      theme: ThemeData(fontFamily: "Poppins", colorScheme: ColorScheme.dark(primary: Colors.black, secondary: Colors.white)),
      routes: {
        "/": (context) => EmbeddedPublicScreen(child: Initialscreen()),
        "/login": (context) => EmbeddedPublicScreen(child: LoginScreen()),
        "/register": (context) => EmbeddedPublicScreen(child: RegisterPage()),
        "/first_entry": (context) => EmbeddedProtectedScreen(child: FirstEntryLogin()),
        "/home": (context) => EmbeddedProtectedScreen(child: HomeView())
      },
    );
  }
}
