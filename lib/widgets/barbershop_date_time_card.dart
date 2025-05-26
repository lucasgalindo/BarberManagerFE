import 'package:flutter/material.dart';

class BarbershopDateTimeCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  
  const BarbershopDateTimeCard({
    super.key, required this.name, required this.description, required this.imageUrl, required this.price
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(30, 30, 30, 0.8),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              imageUrl,
                            ),
                            radius: 30,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  description,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Serviço Selecionado: ${name}",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Preço: R\$ ${price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
            
  }
}