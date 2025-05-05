import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/initial_view_model.dart';
import '../models/user_type_model.dart';
import '../widgets/primary_button.dart';

class Initialscreen extends StatelessWidget {
  const Initialscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return ChangeNotifierProvider(
      create: (_) => InitialScreenViewModel(),
      child: Consumer<InitialScreenViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          body: Container(
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
                  const Text(
                    "BEM VINDO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      height: 1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    "Aqui você encontra os melhores preços.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 40),
                  PrimaryButton(
                    text: "Sou Cliente",
                    onPressed: () {
                      viewModel.selectUser(UserType.cliente);
                      viewModel.goToNextScreen(context);
                    },
                  ),
                  const SizedBox(height: 16),

                  PrimaryButton(
                    text: "Sou Barbeiro",
                    onPressed: () {
                      viewModel.selectUser(UserType.barbeiro);
                      viewModel.goToNextScreen(context);
                    },
                  ),
                  const SizedBox(height: 16),

                  PrimaryButton(
                    text: "Tenho uma Barbearia",
                    onPressed: () {
                      viewModel.selectUser(UserType.donoBarbearia);
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
    );
  }
}
