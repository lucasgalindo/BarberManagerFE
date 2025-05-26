import 'package:barbermanager_fe/models/jwt.dart';
import 'package:flutter/material.dart';

class EmbeddedProtectedScreen extends StatefulWidget {
  final Widget child;

  const EmbeddedProtectedScreen({super.key, required this.child});

  @override
  State<EmbeddedProtectedScreen> createState() => _EmbeddedProtectedScreenState();
}

class _EmbeddedProtectedScreenState extends State<EmbeddedProtectedScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    final result = await getToken();
    if (result == null) {
      setState(() {
        Navigator.of(context).pushReplacementNamed('/');
        isLoading = false;
      });
    } else {
      setState(() {
        
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return widget.child;
  }
}
