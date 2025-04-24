import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/loginViewModel.dart';
import '../widgets/primaryButton.dart';
import '../widgets/textInputField.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          
          body: Container(
            decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_login.png"),
            fit: BoxFit.cover,
          ),
          ),
            child: SingleChildScrollView(
              
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(screenSize.width * 0.05),
                    child: Column(
                      children: [
                        const Text(
                          "BEM VINDO",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Logue-se na sua conta",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        TextInputField(
                          hintText: "E-mail",
                          onChanged: viewModel.updateEmail,
                        ),
                        TextInputField(
                          hintText: "Senha",
                          obscureText: true,
                          onChanged: viewModel.updatePassword,
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          text: "Entrar",
                          onPressed: viewModel.login,
                          borderRadius: 24,
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Ação de ir para o cadastro (Register)
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: "Não tem conta? ",
                                style: TextStyle(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: "Clique aqui para criar uma agora",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
