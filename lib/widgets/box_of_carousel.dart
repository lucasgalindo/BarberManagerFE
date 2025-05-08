import 'package:flutter/material.dart';

class BoxOfCarousel extends StatelessWidget {
  final bool isSelected;
  final Widget child;
  final VoidCallback? onTap;

  const BoxOfCarousel({
    super.key,
    required this.isSelected,
    required this.child,
    this.onTap,
  });

  static const Color _defaultColor = Color.fromRGBO(30, 30, 30, 0.9);
  static const Color _selectedColor = Color.fromRGBO(23, 23, 180, 1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? _selectedColor : _defaultColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}
