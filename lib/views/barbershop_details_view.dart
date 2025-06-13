import 'package:barbermanager_fe/view_models/agendamento_service.dart';
import 'package:barbermanager_fe/views/barbershop_services_view.dart';
import 'package:flutter/material.dart';
import '../models/barber_shop.dart';
import '../widgets/primary_button.dart';

class BarbershopDetailsView extends StatelessWidget {
  final Barbershop barbershop;

  const BarbershopDetailsView({Key? key, required this.barbershop})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          barbershop.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    barbershop.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  barbershop.address,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      barbershop.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.phone, color: Colors.white, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      barbershop.phone,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  "Horário de funcionamento",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      barbershop.workingHours.entries.map((entry) {
                        return Text(
                          "${entry.key}: ${entry.value}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Descrição",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  barbershop.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Center(
              child: PrimaryButton(
                text: "Agendar",
                onPressed: () {
                AgendamentoService().addBarbershop(barbershop);

                  Navigator.pushNamed(
                    context,
                    "/barbershop_services",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
