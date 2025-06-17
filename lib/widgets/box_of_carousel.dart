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
          color:
              isSelected
                  ? Color.fromRGBO(23, 23, 180, 1)
                  : Color.fromRGBO(
                    30,
                    30,
                    30,
                    0.2,
                  ), // Cor diferente se selecionado
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected
                    ? Color.fromRGBO(23, 23, 180, 1)
                    : Color.fromRGBO(30, 30, 30, 0.5),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: child,
      ),
    );
  }
}
