import 'package:barbermanager_fe/views/barber_autonomo_services_view.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/models/barberAutonomos.dart';
import '../widgets/primary_button.dart';

class BarberAutonomoDetailsView extends StatelessWidget {
  final Barberautonomos barber;

  const BarberAutonomoDetailsView({Key? key, required this.barber})
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
          barber.name,
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
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child:
                        barber.imageUrl != null && barber.imageUrl!.isNotEmpty
                            ? Image.network(
                              barber.imageUrl!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                            : Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      (barber.rating ?? 0).toStringAsFixed(1),
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
                      barber.phone ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  "Horário de atendimento",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                barber.workingHours != null
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          barber.workingHours!.entries.map((entry) {
                            return Text(
                              "${entry.key}: ${entry.value}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }).toList(),
                    )
                    : const Text(
                      "Horário não informado",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
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
                  barber.description ?? "",
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              BarberAutonomoServicesView(barber: barber),
                    ),
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
