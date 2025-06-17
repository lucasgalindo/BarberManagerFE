import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/view_models/agendamento_service.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/widgets/primary_button.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';

class BarberAutonomoDateTimeSelectionView extends StatefulWidget {
  final Barberautonomos barber;
  final BarberService selectedService;

  const BarberAutonomoDateTimeSelectionView({
    Key? key,
    required this.barber,
    required this.selectedService,
  }) : super(key: key);

  @override
  State<BarberAutonomoDateTimeSelectionView> createState() =>
      _BarberAutonomoDateTimeSelectionViewState();
}

class _BarberAutonomoDateTimeSelectionViewState
    extends State<BarberAutonomoDateTimeSelectionView> {
  String? selectedDate;
  String? selectedTime;

  final List<String> weekDays = [
    'Dom',
    'Seg',
    'Ter',
    'Qua',
    'Qui',
    'Sex',
    'Sáb',
  ];

  List<Map<String, String>> getNext7Days() {
    final now = DateTime.now();
    return List.generate(7, (i) {
      final date = now.add(Duration(days: i));
      final weekday = weekDays[date.weekday % 7];
      return {
        'weekday': weekday,
        'day': date.day.toString().padLeft(2, '0'),
        'month': date.month.toString().padLeft(2, '0'),
        'label':
            '$weekday\n${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}',
        'value':
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
      };
    });
  }

  // Como o novo modelo não tem workingHours, vamos simular horários disponíveis
  List<String> getAvailableTimes(
    String? selectedDate,
    String? selectedWeekday,
  ) {
    // Exemplo: sempre retorna horários fixos
    return [
      "09:00",
      "09:30",
      "10:00",
      "10:30",
      "11:00",
      "11:30",
      "14:00",
      "14:30",
      "15:00",
      "15:30",
      "16:00",
      "16:30",
    ];
  }

  @override
  Widget build(BuildContext context) {
    final days = getNext7Days();
    final selectedDay = days.firstWhere(
      (d) => d['value'] == selectedDate,
      orElse: () => days[0],
    );
    final selectedWeekday = selectedDay['weekday'];
    final times = getAvailableTimes(selectedDate, selectedWeekday);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Data e Hora",
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
          children: [
            // Datas
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: days.map((date) {
                  final isSelected = selectedDate == date['value'];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: BoxOfCarousel(
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          selectedDate = date['value'];
                          selectedTime = null;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            date['weekday']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${date['day']}/${date['month']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Info do Barbeiro
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(30, 30, 30, 0.8),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    radius: 30,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.barber.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.barber.address,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Serviço Selecionado: ${widget.selectedService.name}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Preço: R\$ ${widget.selectedService.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Horários disponíveis
            if (selectedDate != null && times.isNotEmpty) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Selecione um horário:",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: times.map((time) {
                  final isSelected = selectedTime == time;
                  return BoxOfCarousel(
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                    child: Text(
                      time,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ] else if (selectedDate != null && times.isEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                "Sem horários disponíveis para este dia.",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],

            const Spacer(),

            // Botão Finalizar
            PrimaryButton(
              text: "Finalizar",
              onPressed: () {
                if (selectedDate == null || selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Por favor, selecione uma data e um horário antes de continuar.",
                      ),
                    ),
                  );
                  return;
                }

                final agendamentoService = AgendamentoService();
                final selectedDateTimeParts = selectedTime!.split(":");
                final selectedDateTime = DateTime(
                  int.parse(selectedDate!.split("-")[0]),
                  int.parse(selectedDate!.split("-")[1]),
                  int.parse(selectedDate!.split("-")[2]),
                  int.parse(selectedDateTimeParts[0]),
                  int.parse(selectedDateTimeParts[1]),
                );

                final servico = Servico(
                  barber: null,
                  name: widget.selectedService.name,
                  description: widget.selectedService.name,
                  barberautonomos: widget.barber,
                  price: widget.selectedService.price,
                  barbershop: null, // Adicione a barbearia se necessário
                  dateTime: selectedDateTime,
                );

                agendamentoService.add(servico);
                agendamentoService.confirmarAgendamentos();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Agendamento adicionado com sucesso!"),
                  ),
                );
                Future.delayed(Duration(seconds: 2), () => Navigator.pushNamedAndRemoveUntil(context, "/agendamentos", (Route<dynamic> route) => false),);
                
              },
            ),
          ],
        ),
      ),
    );
  }
}