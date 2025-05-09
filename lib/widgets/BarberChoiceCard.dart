import 'package:flutter/material.dart';

class BarberChoiceCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final VoidCallback onTap;

  const BarberChoiceCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(30, 30, 30, 0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color.fromRGBO(30, 30, 30, 0.5),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
