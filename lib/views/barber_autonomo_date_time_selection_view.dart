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

  List<String> getAvailableTimes(
    String? selectedDate,
    String? selectedWeekday,
  ) {
    if (selectedWeekday == null) return [];
    final workingHours = widget.barber.workingHours?[selectedWeekday];

    if (workingHours == null ||
        workingHours == "Fechado" ||
        !workingHours.contains('-')) {
      return [];
    }

    final hours = workingHours.split(" - ");
    final opening = _parseTime(hours[0]);
    final closing = _parseTime(hours[1]);

    final times = <String>[];
    var current = TimeOfDay(hour: opening.hour, minute: opening.minute);

    while (current.hour < closing.hour ||
        (current.hour == closing.hour && current.minute < closing.minute)) {
      times.add(
        '${current.hour.toString().padLeft(2, '0')}:${current.minute.toString().padLeft(2, '0')}',
      );
      final nextMinute = current.minute + 30;
      current = TimeOfDay(
        hour: current.hour + (nextMinute >= 60 ? 1 : 0),
        minute: nextMinute % 60,
      );
    }
    return times;
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(":");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
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
                children:
                    days.map((date) {
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
                    backgroundImage:
                        widget.barber.imageUrl?.isNotEmpty == true
                            ? NetworkImage(widget.barber.imageUrl!)
                            : null,
                    radius: 30,
                    child:
                        (widget.barber.imageUrl?.isEmpty ?? true)
                            ? const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            )
                            : null,
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
                          widget.barber.description ?? "",
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
                children:
                    times.map((time) {
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

                // TODO: Coloque aqui a lógica para avançar ou confirmar o agendamento.
              },
            ),
          ],
        ),
      ),
    );
  }
}
