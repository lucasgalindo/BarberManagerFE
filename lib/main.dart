import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/view_models/auth_provider.dart';
import 'package:barbermanager_fe/views/barbershop_services_view.dart';
import 'package:barbermanager_fe/views/chat_view.dart';
import 'package:barbermanager_fe/views/initial_screen.dart';
import 'package:barbermanager_fe/views/login_screen.dart';
import 'package:barbermanager_fe/views/embedded_protected_screen.dart';
import 'package:barbermanager_fe/views/embedded_public_screen.dart';
import 'package:barbermanager_fe/views/protected/barber_view.dart';
import 'package:barbermanager_fe/views/protected/first_entry_login.dart';
import 'package:barbermanager_fe/views/protected/home_view.dart';
import 'package:barbermanager_fe/views/register_page.dart';
import 'package:barbermanager_fe/widgets/service_category_manager.dart';
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
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.dark(
          primary: const Color.fromARGB(255, 0, 0, 0),
          secondary: Colors.white,
        ),
      ),
      routes: {
        "/": (context) => EmbeddedPublicScreen(child: Initialscreen()),
        "/login": (context) => EmbeddedPublicScreen(child: LoginScreen()),
        "/register": (context) => EmbeddedPublicScreen(child: RegisterPage()),
        "/first_entry":
            (context) => EmbeddedProtectedScreen(child: FirstEntryLogin()),
        "/home": (context) => EmbeddedProtectedScreen(child: HomeView()),
        "/barber": (context) => EmbeddedProtectedScreen(child: BarberView()),
        "/chat": (context) => EmbeddedProtectedScreen(child: ChatView()),
        "/services":
            (context) => EmbeddedProtectedScreen(
              child: Builder(
                builder: (context) {
                  final arguments =
                      ModalRoute.of(context)!.settings.arguments
                          as Map<String, dynamic>?;

                  if (arguments == null ||
                      !arguments.containsKey('barbershop')) {
                    // Exibe uma mensagem de erro ou redireciona para outra tela
                    return const Center(
                      child: Text(
                        "Erro: Dados da barbearia não foram fornecidos.",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }

                  final barbershop = arguments['barbershop'] as Barbershop;
                  final previousServices =
                      arguments['previousServices']
                          as List<Map<String, dynamic>>? ??
                      [];

                  return BarbershopServicesView(
                    barbershop: barbershop,
                    previousServices: previousServices,
                  );
                },
              ),
            ),
      },
    );
  }
}
