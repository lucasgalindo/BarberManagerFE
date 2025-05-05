import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function(String)? onChanged;

  const TextInputField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        obscureText: obscureText,
        cursorColor: Colors.white,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(30, 30, 30, 80),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
