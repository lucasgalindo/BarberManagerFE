import 'package:flutter/material.dart';

class SecondButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? borderRadius;
  final TextStyle? textStyle;

  const SecondButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius = 14.0,
    this.textStyle,
  });

  static const Color _primaryColor = Color.fromRGBO(23, 23, 180, 1);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 2, color: _primaryColor),
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          backgroundColor: Colors.transparent, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        

        onPressed: onPressed,
        child: Text(
          text,
          style:
              textStyle ?? const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
