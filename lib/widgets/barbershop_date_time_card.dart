import 'package:barbermanager_fe/view_models/agendamento_service.dart';
import 'package:flutter/material.dart';

class BarbershopDateTimeCard extends StatelessWidget {
  final Servico service;
  final VoidCallback onTap;
  final VoidCallback onDelete; // NOVO
  final String? selectedTime;

  const BarbershopDateTimeCard({
    required this.service,
    required this.onTap,
    required this.onDelete, // NOVO
    this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(12.0),

        child: Column(
          children: [
            ElevatedButton(
              onPressed: onTap, // Chama o callback recebido
              clipBehavior: Clip.antiAlias,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12.0),
                backgroundColor: const Color.fromARGB(255, 18, 18, 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(
                    color: Color.fromRGBO(30, 30, 30, 0.8),
                    width: 1.0,
                  ),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            service.barbershop!.imageUrl.isNotEmpty
                                ? service.barbershop!.imageUrl
                                : 'https://via.placeholder.com/150',
                          ),
                          radius: 30,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service.barbershop!.name,
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
                                service.barbershop!.description,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              const SizedBox(height: 4),
                              if (selectedTime != null)
                                Text(
                                  "Horário Selecionado: $selectedTime",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              Text(
                                "Serviço Selecionado: ${service.name}",
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
                                "Preço: R\$ ${service.price.toStringAsFixed(2)}",
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
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
