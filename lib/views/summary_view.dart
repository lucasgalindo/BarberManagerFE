import 'package:barbermanager_fe/widgets/primary_button.dart';
import 'package:barbermanager_fe/widgets/InfoBox.dart';
import 'package:flutter/material.dart';

class SummaryView extends StatelessWidget {
  final String clientName;
  final String barbershopName;
  final String barbershopAddress;
  final String barbershopPhone;
  final List<Map<String, dynamic>> services;
  final String totalPrice;

  const SummaryView({
    Key? key,
    required this.clientName,
    required this.barbershopName,
    required this.barbershopAddress,
    required this.barbershopPhone,
    required this.services,
    required this.totalPrice,
  }) : super(key: key);

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
        title: const Text(
          "Resumo do Agendamento",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Caixa Cliente
            InfoBox(
              title: "Cliente",
              children: [
                Text(
                  clientName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Caixa Local
            InfoBox(
              title: "Local",
              children: [
                Text(
                  barbershopName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  barbershopAddress,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Caixa Data e Hora
            InfoBox(
              title: "Data e Hora",
              children:
                  services.map((service) {
                    return Text(
                      "${service['date']} às ${service['time']}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 8),

            // Caixa Contato da Barbearia
            InfoBox(
              title: "Contato da Barbearia",
              children: [
                Text(
                  barbershopPhone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Separador
            const Divider(color: Colors.white70, thickness: 1),
            const SizedBox(height: 24),

            // Caixa Serviços
            InfoBox(
              title: "Serviço(s)",
              children:
                  services.map((service) {
                    return Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service['service'].name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Profissional: ${service['barber'].name}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Valor total",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "R\$ $totalPrice",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Botão Finalizar
            PrimaryButton(
              text: "Finalizar",
              onPressed: () {
                // Lógica para finalizar o agendamento
              },
            ),
          ],
        ),
      ),
    );
  }
}
