import 'package:barbermanager_fe/models/userTypeModel.dart';
import 'package:barbermanager_fe/view_models/InitialViewModel.dart';
import 'package:barbermanager_fe/views/embedded_protected_screen.dart';
import 'package:barbermanager_fe/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstEntryLogin extends StatelessWidget  {
  const FirstEntryLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return EmbeddedProtectedScreen(
      child: ChangeNotifierProvider(
        create: (_) => InitialScreenViewModel(),
        child: Consumer<InitialScreenViewModel>(
          builder: (context, viewModel, _) => Scaffold(
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      text: "Buscar por barbeiros",
                      onPressed: () {
                        viewModel.selectUser(UserType.cliente);
                        viewModel.goToNextScreen(context);
                      },
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      text: "Buscar por barbearias",
                      onPressed: () {
                        viewModel.selectUser(UserType.barbeiro);
                        viewModel.goToNextScreen(context);
                      },
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
