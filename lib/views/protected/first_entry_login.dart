import 'package:barbermanager_fe/view_models/first_entry_view_model.dart';
import 'package:barbermanager_fe/views/protected/barber_view.dart';
import 'package:barbermanager_fe/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstEntryLogin extends StatelessWidget {
  const FirstEntryLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return ChangeNotifierProvider(
      create: (_) => FirstEntryViewModel(),
      child: Consumer<FirstEntryViewModel>(
        builder:
            (context, viewModel, _) => Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        "Como deseja buscar um serviço?",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(height: 40),
                      PrimaryButton(
                        text: "Buscar por barbeiros",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BarberView(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        text: "Buscar por barbearias",
                        onPressed: () {
                          viewModel.nextScreen(1, context);
                        },
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
