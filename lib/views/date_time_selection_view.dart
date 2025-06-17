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

  String _formatDayMonth(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    return "$day/$month";
  }

  @override
  Widget build(BuildContext context) {
    final availableDates = AgendamentoService().getAvailableDates();
    final weekDates =
        availableDates
            .map(
              (date) => {
                "date": date,
                "day": _formatDayMonth(date),
                "weekday": _getWeekdayFromDate(date),
              },
            )
            .toList();

    bool isDateSelected = AgendamentoService().selectedDate != null;
    bool allTimesSelected =
        AgendamentoService().agendamentos.isNotEmpty &&
        AgendamentoService().agendamentos.every(
          (servico) =>
              AgendamentoService().selectedTimePerService[servico] != null,
        );
    bool allDatesSelected =
        AgendamentoService().agendamentos.isNotEmpty &&
        AgendamentoService().agendamentos.every(
          (servico) =>
              AgendamentoService().selectedDatePerService[servico] != null,
        );

    // Atualiza horários e datas disponíveis para novos serviços adicionados
    if (isDateSelected) {
      for (var servico in AgendamentoService().agendamentos) {
        // Atualiza horários se necessário
        if (AgendamentoService().availableTimesPerService[servico] == null ||
            AgendamentoService().availableTimesPerService[servico]!.isEmpty) {
          AgendamentoService().availableTimesPerService[servico] =
              AgendamentoService().getAvailableTimesForBarber(
                servico.barber,
                AgendamentoService().selectedDate!,
              );
        }
        // Atualiza data selecionada por serviço se necessário
        if (AgendamentoService().selectedDatePerService[servico] == null) {
          AgendamentoService().selectedDatePerService[servico] =
              AgendamentoService().selectedDate;
        }
      }
    }

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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  'Selecione uma data',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Seleção de datas
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...weekDates.map((date) {
                    final isSelected =
                        AgendamentoService().selectedDate != null &&
                        date['date'] is DateTime &&
                        AgendamentoService().selectedDate!.year ==
                            (date['date'] as DateTime).year &&
                        AgendamentoService().selectedDate!.month ==
                            (date['date'] as DateTime).month &&
                        AgendamentoService().selectedDate!.day ==
                            (date['date'] as DateTime).day;
                    final isAvailable = availableDates.contains(date['date']);
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Opacity(
                        opacity: isAvailable ? 1.0 : 0.3,
                        child: BoxOfCarousel(
                          isSelected: isSelected,
                          onTap:
                              isAvailable
                                  ? () {
                                    setState(() {
                                      AgendamentoService().selectedDate =
                                          date['date'] as DateTime;
                                      // Limpa horários e datas selecionados ao trocar a data
                                      AgendamentoService()
                                          .selectedTimePerService
                                          .updateAll((key, value) => null);
                                      AgendamentoService()
                                          .selectedDatePerService
                                          .updateAll((key, value) => null);
                                      // Atualiza horários e datas disponíveis para cada serviço
                                      for (var servico
                                          in AgendamentoService()
                                              .agendamentos) {
                                        AgendamentoService()
                                                .availableTimesPerService[servico] =
                                            AgendamentoService()
                                                .getAvailableTimesForBarber(
                                                  servico.barber,
                                                  date['date'] as DateTime,
                                                );
                                        AgendamentoService()
                                                .selectedDatePerService[servico] =
                                            date['date'] as DateTime;
                                      }
                                    });
                                  }
                                  : null,
                          child: Column(
                            children: [
                              Text(
                                date['weekday'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                date['day'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
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
          // Serviços e horários disponíveis
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...AgendamentoService().agendamentos.map((servico) {
                    final times =
                        AgendamentoService()
                            .availableTimesPerService[servico] ??
                        [];
                    // Pega a data selecionada para o serviço
                    DateTime? selectedDateForService =
                        AgendamentoService().selectedDatePerService[servico];
                    String? selectedDateStr =
                        selectedDateForService != null
                            ? _formatDayMonth(selectedDateForService)
                            : null;
                    String? selectedTime =
                        AgendamentoService().selectedTimePerService[servico];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BarbershopDateTimeCard(
                          service: servico,
                          onTap: () {},
                          selectedTime: selectedTime,
                          selectedDate: selectedDateStr,
                          onDelete: () {
                            setState(() {
                              buttonPressed(servico);
                            });
                          },
                        ),
                        if (isDateSelected)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 8,
                              bottom: 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Selecione um horário",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (times.isEmpty)
                                  const Text(
                                    "Nenhum horário disponível para este serviço.",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  )
                                else
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ...times.map(
                                          (time) => Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8.0,
                                            ),
                                            child: BoxOfCarousel(
                                              isSelected: selectedTime == time,
                                              onTap: () {
                                                setState(() {
                                                  AgendamentoService()
                                                          .selectedTimePerService[servico] =
                                                      time;
                                                });
                                              },
                                              child: Text(
                                                time,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }).toList(),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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
              text: 'Agendar mais serviço',
              onPressed:
                  (isDateSelected && allTimesSelected && allDatesSelected)
                      ? () {
                        Navigator.restorablePushNamedAndRemoveUntil(
                          context,
                          "/barbershop_services",
                          (Route<dynamic> route) => false,
                        );
                      }
                      : () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(
              text: 'Continuar',
              onPressed:
                  (isDateSelected && allTimesSelected && allDatesSelected)
                      ? () {
                        Navigator.pushNamed(
                          context,
                          "/summary",
                          arguments: AgendamentoService().agendamentos.last,
                        );
                      }
                      : () {},
            ),
          ),
        ],
      ),
    );
  }
}
