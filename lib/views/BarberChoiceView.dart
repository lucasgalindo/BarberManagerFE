import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/views/DateTimeSelectionView.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/widgets/BarberChoiceCard.dart';

class BarberChoiceView extends StatelessWidget {
  final List<Barber> team;
  final BarberService selectedService;
  final Map<String, String>
  workingHours; // Horários de funcionamento da barbearia

  const BarberChoiceView({
    Key? key,
    required this.team,
    required this.selectedService,
    required this.workingHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filtra os barbeiros que realizam o serviço selecionado
    final filteredBarbers =
        team.where((barber) {
          return barber.services.contains(selectedService.name);
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DateTimeSelectionView(
                                  selectedBarber:
                                      barber, // Passa o barbeiro selecionado
                                  selectedService:
                                      selectedService, // Passa o serviço selecionado
                                  workingHours:
                                      workingHours, // Passa os horários de funcionamento
                                ),
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
