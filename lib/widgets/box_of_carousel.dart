import 'package:flutter/material.dart';

class BoxOfCarousel extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget child;

  const BoxOfCarousel({
    Key? key,
    required this.isSelected,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[800], // Cor diferente se selecionado
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: child,
      ),
    );
  }
}