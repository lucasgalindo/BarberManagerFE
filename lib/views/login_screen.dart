import 'package:barbermanager_fe/models/user_creddentials.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/login_view_model.dart';
import '../widgets/primary_button.dart';
import '../widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen([Key? key]) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    var userType = ModalRoute.of(context)!.settings.arguments;
    getTypeUser();


    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder:
            (context, viewModel, child) => Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background_login.png"),
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
                                        "BEM VINDO",
                                        style: TextStyle(
                                          fontSize: 50,
                                          height: 0.8,
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
                                        onPressed:
                                            () => viewModel.login(context),
                                        borderRadius: 24,
                                      ),
                                      const SizedBox(height: 24),
                                      Center(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/register',
                                              arguments: userType,
                                            );
                                          },
                                          child: const Text.rich(
                                            TextSpan(
                                              text: "Não tem conta?",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      " Clique aqui para criar uma agora",
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
                    Positioned(
                      top:
                          MediaQuery.of(context).padding.top +
                          16, // respeita o status bar
                      left: 16,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
