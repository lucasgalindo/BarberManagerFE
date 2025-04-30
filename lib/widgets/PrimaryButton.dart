import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final borderRadius;
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius = 14.0,
  });

  static const Color _primaryColor = Color.fromRGBO(23, 23, 180, 1);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
