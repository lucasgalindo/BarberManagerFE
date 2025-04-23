import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crie sua conta',
      theme: ThemeData.dark(),
      home: const CreateAccountScreen(),
    );
  }
}

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                
                  ClipOval(
                    child: Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey[800],
                      child: Image.asset(
                        'assets/lg2.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.account_circle,
                              size: 150, color: Colors.white);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'CRIE SUA CONTA',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

       
                  Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Image.asset(
                        'assets/face.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.facebook,
                              color: Colors.black);
                        },
                      ),
                      label: const Text('Entrar com o facebook',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 15),

         
                  Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Image.asset(
                        'assets/google.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.g_mobiledata,
                              size: 28, color: Colors.black);
                        },
                      ),
                      label: const Text('Entrar com o google',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 15),

   
                  Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Image.asset(
                        'assets/apple.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.apple, color: Colors.black);
                        },
                      ),
                      label: const Text('Entrar com o icloud',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Já possui uma conta? Faça login',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
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
