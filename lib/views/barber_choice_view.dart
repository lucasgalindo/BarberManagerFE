import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/view_models/agendamento_service.dart';
import 'package:barbermanager_fe/view_models/client_handle_service.dart';
import 'package:barbermanager_fe/views/date_time_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/widgets/BarberChoiceCard.dart';

class BarberChoiceView extends StatelessWidget {
  BarberChoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredBarbers =
        AgendamentoService().barbershop!.team.where((barber) {
          return barber.services.contains(
            AgendamentoService().currentService.name,
          );
        }).toList();

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
          "Escolha o profissional",
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
        child:
            filteredBarbers.isNotEmpty
                ? ListView.separated(
                  itemCount: filteredBarbers.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final barber = filteredBarbers[index];
                    return BarberChoiceCard(
                      name: barber.name,
                      imageUrl: barber.imageUrl,
                      description: barber.description,
                      onTap: () {
                        // Salva o barbeiro escolhido no AgendamentoService
                        AgendamentoService().addBarber(barber);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DateTimeSelectionView(),
                          ),
                        );
                      },
                    );
                  },
                )
                : const Center(
                  child: Text(
                    "Nenhum profissional disponível para este serviço.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
      ),
    );
  }
}
