import 'package:flutter/material.dart';

class BarberServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;

  const BarberServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(30, 30, 30, 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromRGBO(30, 30, 30, 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            price,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
