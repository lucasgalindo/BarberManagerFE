import 'package:barbermanager_fe/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';

class Initialscreen extends StatefulWidget {
  const Initialscreen({super.key});

  @override
  State<Initialscreen> createState() => _Initialscreen();
}

class _Initialscreen extends State<Initialscreen> {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
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

              

              const SizedBox(height: 16),
              PrimaryButton(text: "Sou Cliente", onPressed: () =>{}),
              const SizedBox(height: 16),
              PrimaryButton(text: "Sou Barbeiro", onPressed: () =>{}),
              const SizedBox(height: 16),
              PrimaryButton(text: "Tenho uma Barbearia", onPressed: () =>{}),
              
              
              SizedBox(height: screenSize.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }
}