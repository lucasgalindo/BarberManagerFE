import 'package:barbermanager_fe/view_models/agendamento_service.dart';
import 'package:barbermanager_fe/widgets/barbershop_date_time_card.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';
import 'package:barbermanager_fe/widgets/primary_button.dart';
import 'package:barbermanager_fe/widgets/second_button.dart';
import 'package:flutter/material.dart';

class DateTimeSelectionView extends StatefulWidget {
  const DateTimeSelectionView({Key? key}) : super(key: key);

  @override
  _DateTimeSelectionViewState createState() => _DateTimeSelectionViewState();
}

class _DateTimeSelectionViewState extends State<DateTimeSelectionView> {
  DateTime? selectedDate = AgendamentoService().selectedDate;

  void buttonPressed(servico) {
    setState(() {
      if (AgendamentoService().agendamentos.length > 1) {
        int index = AgendamentoService().agendamentos.indexOf(servico);
        AgendamentoService().remove(index);
      } else {
        AgendamentoService().removeLast();
        Navigator.pop(context);
      }
    });
  }

  String _getWeekdayFromDate(DateTime date) {
    return [
      "Domingo",
      "Segunda",
      "Terça",
      "Quarta",
      "Quinta",
      "Sexta",
      "Sábado",
    ][date.weekday % 7];
  }

  void onServiceTap(servico) {
    if (AgendamentoService().selectedDate == null) return;
    final times = AgendamentoService().getAvailableTimesForBarber(
      servico.barber,
      AgendamentoService().selectedDate!,
    );
    setState(() {
      final isOpen = AgendamentoService().showTimesPerService[servico] == true;
      if (isOpen) {
        AgendamentoService().showTimesPerService[servico] = false;
      } else {
        AgendamentoService().availableTimesPerService[servico] = times;
        AgendamentoService().showTimesPerService[servico] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableDates = AgendamentoService().getAvailableDates();
    final weekDates = availableDates.map((date) => {
      "date": date,
      "day": "${date.day}/${date.month}",
      "weekday": _getWeekdayFromDate(date),
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data e Hora', textAlign: TextAlign.center),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            AgendamentoService().removeLast();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'Selecione a data e hora para o seu agendamento',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  ...weekDates.map((date) {
                    final isSelected = AgendamentoService().selectedDate != null &&
                        date['date'] is DateTime &&
                        AgendamentoService().selectedDate!.year == (date['date'] as DateTime).year &&
                        AgendamentoService().selectedDate!.month == (date['date'] as DateTime).month &&
                        AgendamentoService().selectedDate!.day == (date['date'] as DateTime).day;
                    final isAvailable = availableDates.contains(date['date']);
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Opacity(
                        opacity: isAvailable ? 1.0 : 0.3,
                        child: BoxOfCarousel(
                          isSelected: isSelected,
                          onTap: isAvailable
                              ? () {
                                  setState(() {
                                    AgendamentoService().selectedDate = date['date'] as DateTime;
                                    AgendamentoService().selectedTimePerService.clear();
                                    AgendamentoService().availableTimesPerService.clear();
                                    AgendamentoService().showTimesPerService.clear();
                                  });
                                }
                              : null,
                          child: Column(
                            children: [
                              Text(
                                date['weekday'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                date['day'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          // --- Seção scrollável dos serviços ---
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...AgendamentoService().agendamentos.map((servico) {
                    return Column(
                      children: [
                        BarbershopDateTimeCard(
                          service: servico,
                          onTap: () => onServiceTap(servico),
                          selectedTime: AgendamentoService().selectedTimePerService[servico],
                          onDelete: () {
                            setState(() {
                              AgendamentoService().removeServico(servico);
                              if (AgendamentoService().agendamentos.isEmpty) {
                                Navigator.pop(context);
                              }
                            });
                          },
                        ),
                        if (AgendamentoService().showTimesPerService[servico] == true &&
                            (AgendamentoService().availableTimesPerService[servico]?.isNotEmpty ?? false))
                          ...AgendamentoService().availableTimesPerService[servico]!.map((time) => RadioListTile<String>(
                                title: Text(time),
                                value: time,
                                groupValue: AgendamentoService().selectedTimePerService[servico],
                                onChanged: (value) {
                                  setState(() {
                                    AgendamentoService().selectedTimePerService[servico] = value;
                                  });
                                },
                              )),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          // --- Fixo na parte de baixo ---
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Você selecionou ${AgendamentoService().agendamentos.length} serviço(s)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Subtotal: R\$ ${AgendamentoService().getTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SecondButton(
              text: 'Agendar Serviço',
              onPressed: () {
                Navigator.restorablePushNamedAndRemoveUntil(
                  context,
                  "/barbershop_services",
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(
              text: 'Continuar',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/summary",
                  arguments: AgendamentoService().agendamentos.last,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
