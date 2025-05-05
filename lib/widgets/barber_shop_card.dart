import 'package:flutter/material.dart';
import '../models/barber_shop.dart';

class BarbershopCard extends StatelessWidget {
  final Barbershop shop;

  const BarbershopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shadowColor: Colors.grey[600],
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(shop.imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shop.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                Text(shop.address, style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(shop.rating.toString(), style: TextStyle(color: Colors.white),),
                    const SizedBox(width: 12),
                    const Icon(Icons.phone, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(shop.phone, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
