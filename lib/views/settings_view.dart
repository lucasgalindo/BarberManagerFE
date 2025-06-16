import 'package:barbermanager_fe/models/customer.dart';
import 'package:barbermanager_fe/repositories/user_repository.dart';
import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/widgets/InfoBox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class SettingsView extends StatefulWidget {
  final String token;

  const SettingsView({super.key, required this.token});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool allowNotification = false;
  late Customer user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  void getData() async{
    Map<String, dynamic>? userData = await getUserData();
    setState(() {
      user = Customer.fromJson(userData!);
    });
  }

  @override
  Widget build(BuildContext context) {


    if(user.usuario != null){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Configurações'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: const Color.fromRGBO(23, 23, 180, 1),
                child: const Icon(Icons.person, color: Colors.white, size: 40),
              ),
            ),
            const SizedBox(height: 32),
            InfoBox(
              title: "Nome do Usuário",
              children: [
                Text(
                  user.usuario!.nome ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const SizedBox(height: 12),
            InfoBox(
              title: "E-mail",
              children: [
                Text(
                  user.usuario!.email ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const SizedBox(height: 12),
            InfoBox(
              title: "Permitir Notificação",
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: allowNotification,
                      onChanged: (value) async {
                        if (value == true) {
                          if (!kIsWeb &&
                              (Platform.isAndroid || Platform.isIOS)) {
                            final status =
                                await Permission.notification.request();
                            if (status.isGranted) {
                              setState(() {
                                allowNotification = true;
                              });
                            } else {
                              setState(() {
                                allowNotification = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Permissão de notificação negada.',
                                  ),
                                ),
                              );
                            }
                          } else {
                            setState(() {
                              allowNotification = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Permissão de notificação não suportada nesta plataforma.',
                                ),
                              ),
                            );
                          }
                        } else {
                          setState(() {
                            allowNotification = false;
                          });
                        }
                      },
                      activeColor: const Color.fromRGBO(23, 23, 180, 1),
                      checkColor: Colors.white,
                    ),
                    const Text(
                      "Receber notificações",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  
    }
    else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Configurações'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const Center(
          child: Text(
            'Usuário não encontrado.',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      );
    }
  }
}
