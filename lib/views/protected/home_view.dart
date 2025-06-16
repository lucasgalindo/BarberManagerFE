import 'package:barbermanager_fe/models/user_creddentials.dart';
import 'package:barbermanager_fe/models/user_type_model.dart';
import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:barbermanager_fe/widgets/barber_screen.dart';
import 'package:barbermanager_fe/widgets/client_screen.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String username = "...";
  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final userData = await getUserData();
    if (userData != null && userData['usuario'] != null) {
      setState(() {
        username = userData['usuario']['nome'];
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: getTypeUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          final userType = snapshot.data!;
          return switchBetweenUserType(username, userType);
        }
      },
    );
  }
    

  switchBetweenUserType(String username, int userType) {
      UserType type = UserType.values.firstWhere((e) => e.valor == userType);
      
      switch(type){
        case UserType.barbeiro:
          return BarberScreen(username: username,);
        case UserType.cliente:
          return ClientScreen(username: username);
        case UserType.donoBarbearia:
          return Text("");
      }
  }
  
}
