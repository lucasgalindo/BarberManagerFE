import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/SeekserviceViewModel.dart';
import '../widgets/primaryButton.dart';

class Seekservicescreen extends StatelessWidget {
  const Seekservicescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return ChangeNotifierProvider(
      create: (_) => SeekserviceViewModel(),
      child: Consumer<SeekserviceViewModel>(
        builder:
            (context, viewModel, child) => Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: screenSize.height,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.05,
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Como deseja \n buscar um serviço?",
                                        style: TextStyle(
                                          fontSize: 24,
                                          height: 1,
                                          fontWeight: FontWeight.w100,
                                          color: Color.fromARGB(
                                            214,
                                            255,
                                            255,
                                            255,
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 24),
                                      PrimaryButton(
                                        text: "Buscar por Barbeiros",
                                        onPressed: () {
                                          viewModel.goToMainScreen(context);
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      PrimaryButton(
                                        text: "Buscar por Barbearias",
                                        onPressed: () {
                                          viewModel.goToMainScreen(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
