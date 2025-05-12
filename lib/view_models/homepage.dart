import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barbearia App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.amber,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/perfil.png'),
            ),
            const SizedBox(height: 12), 
            const Text(
              'Olá, Jone',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
              ),
            ),
          ],
        ),
        actions: [
          Transform.translate(
            offset: Offset(0, -20), 
            child: IconButton(
              icon: Image.asset('assets/pesquisa.png'),
              onPressed: () {},
            ),
          ),
          Transform.translate(
            offset: Offset(0, -20),
            child: IconButton(
              icon: Image.asset('assets/grade.png'),
              onPressed: () {},
            ),
          ),
        ],
        toolbarHeight:
            100, 
      ),
     
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
        
           
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/banner.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    bottom: 50,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCarouselIndicator(true),
                        const SizedBox(width: 8),
                        _buildCarouselIndicator(false),
                        const SizedBox(width: 8),
                        _buildCarouselIndicator(false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
       
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              padding: const EdgeInsets.all(12),
              children: [
                _buildBarberShopCard(
                  'CAMERIDAS - BARRELINO',
                  'Alecito – 0,000m',
                  'Aberto – 08:00h',
                ),
                _buildBarberShopCard(
                  'dastacenta - BARRETINO',
                  'Alecito – 0,000m',
                  'Aberto – 08:00h',
                ),
                _buildBarberShopCard(
                  'dastacenta - ALEGENCIO',
                  'Alecito – 0,000m',
                  'Aberto – 08:00h',
                ),
                _buildBarberShopCard(
                  'dastacenta - BARRETINO',
                  'Alecito – 0,000m',
                  'Aberto – 08:00h',
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/home.png', width: 24),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/marcacoes.png', width: 24),
            label: 'Agendamentos',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/msg.png', width: 24),
            label: 'Mensagens',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/usuario.png', width: 24),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselIndicator(bool isActive) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.amber : Colors.grey,
      ),
    );
  }

  Widget _buildBarberShopCard(String title, String address, String status) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Image.asset('assets/barber.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  address,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  status,
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
