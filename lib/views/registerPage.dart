import 'package:barbermanager_fe/models/userTypeModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/registerViewModel.dart';
import '../widgets/primaryButton.dart';
import '../widgets/textInputField.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userType = ModalRoute.of(context)!.settings.arguments;
    print(userType);
    final screenSize = MediaQuery.sizeOf(context);
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                children: [
                  const Text(
                    "CRIE SUA CONTA",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextInputField(
                    hintText: "Nome de usuario",
                    onChanged: viewModel.updateUsername,
                  ),
                  TextInputField(
                    hintText: "Email",
                    onChanged: viewModel.updateEmail,
                  ),
                  TextInputField(
                    hintText: "Celular",
                    onChanged: viewModel.updatePhone,
                  ),
                  TextInputField(
                    hintText: "Data de nascimento",
                    onChanged: viewModel.updateBirthDate,
                  ),
                  TextInputField(
                    hintText: "Senha",
                    obscureText: true,
                    onChanged: viewModel.updatePassword,
                  ),
                  TextInputField(
                    hintText: "Confirme sua senha",
                    obscureText: true,
                    onChanged: viewModel.updateConfirmPassword,
                  ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: "Para concluir o cadastro você precisa concordar com os ",
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      children: [
                        TextSpan(
                          text: "Termos e Condições de Uso",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  CheckboxListTile(
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    value: viewModel.agreeToTerms,
                    onChanged: viewModel.toggleAgreeToTerms,
                    title: const Text.rich(
                      TextSpan(
                        text: "Concordo com os",
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "Termos e condições de uso.",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    text: "Cadastrar-se",
                    onPressed: viewModel.submit,
                    borderRadius: 24,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text.rich(
                        TextSpan(
                          text: "Já tem uma conta? ",
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                              text: "Entrar",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  )
                ],
              )
                  
                  ),
                ],
              ),
            ),
             )
          ),
        ),
    );
  }
}
