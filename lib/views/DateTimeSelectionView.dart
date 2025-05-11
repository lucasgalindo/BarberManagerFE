import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';

class DateTimeSelectionView extends StatefulWidget {
  final Barber selectedBarber;
  final BarberService selectedService;
  final Map<String, String> workingHours;

  const DateTimeSelectionView({
    Key? key,
    required this.selectedBarber,
    required this.selectedService,
    required this.workingHours,
  }) : super(key: key);

  @override
  _DateTimeSelectionViewState createState() => _DateTimeSelectionViewState();
}

class _DateTimeSelectionViewState extends State<DateTimeSelectionView> {
  String? selectedDate;
  String? selectedTime;
  List<String> availableTimes = [];

  @override
  void initState() {
    super.initState();
    _initializeAvailableDates();
  }

  void _initializeAvailableDates() {
    final currentDate = DateTime.now();
    final dates =
        List.generate(7, (index) {
          final date = currentDate.add(Duration(days: index));
          final formattedDate = "${date.day}/${date.month}";
          final weekday = _getWeekdayFromDate(date);
          final workingHours = widget.workingHours[weekday];

          if (workingHours != null && workingHours != "Fechado") {
            return formattedDate;
          }
          return null;
        }).where((date) => date != null).toList();

    setState(() {
      availableTimes = dates.cast<String>();
    });
  }

  void _updateAvailableTimes(String date) {
    final weekday = _getWeekdayFromDateString(date);
    final workingHours = widget.workingHours[weekday];

    if (workingHours != null && workingHours != "Fechado") {
      final hours = workingHours.split(" - ");
      final openingTime = _parseTime(hours[0]);
      final closingTime = _parseTime(hours[1]);

      final times = <String>[];
      var currentTime = openingTime;
      while (currentTime.hour < closingTime.hour ||
          (currentTime.hour == closingTime.hour &&
              currentTime.minute < closingTime.minute)) {
        final formattedTime =
            "${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}";
        times.add(formattedTime);

        final newMinute = currentTime.minute + 30;
        if (newMinute >= 60) {
          currentTime = currentTime.replacing(
            hour: currentTime.hour + 1,
            minute: newMinute - 60,
          );
        } else {
          currentTime = currentTime.replacing(minute: newMinute);
        }
      }

      setState(() {
        availableTimes = times;
      });
    } else {
      setState(() {
        availableTimes = [];
      });
    }
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

  String _getWeekdayFromDateString(String date) {
    final parts = date.split("/");
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = DateTime.now().year;
    final dateTime = DateTime(year, month, day);
    return _getWeekdayFromDate(dateTime);
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(":");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final weekDates = List.generate(7, (index) {
      final date = currentDate.add(Duration(days: index));
      return {
        "day": "${date.day}/${date.month}",
        "weekday": _getWeekdayFromDate(date),
      };
    });

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carrossel com as datas disponíveis
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    weekDates.map((date) {
                      final isSelected = selectedDate == date['day'];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: BoxOfCarousel(
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              selectedDate = date['day'];
                              _updateAvailableTimes(selectedDate!);
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
                                date['day']!,
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

            // Informações do barbeiro e do serviço selecionado
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(30, 30, 30, 0.8),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.selectedBarber.imageUrl,
                            ),
                            radius: 30,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.selectedBarber.name,
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
                                  widget.selectedBarber.description,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Serviço Selecionado: ${widget.selectedService.name}",
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
                                  "Preço: R\$ ${widget.selectedService.price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Se uma data for selecionada, exibe a mensagem de seleção de horário juntamente
            // com a lista de horários disponíveis
            if (selectedDate != null) ...[
              const Text(
                "Selecione um horário:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Aqui é a lista de horários disponíveis
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(30, 30, 30, 0.8),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            availableTimes.map((time) {
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
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
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
                      "R\$ ${widget.selectedService.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFF1717B4),
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/services',
                      ); // ajustar os parametros aqui, pois gera uma exception.
                    },
                    child: const Text(
                      "Agendar mais serviços",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: "Finalizar",
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontSize: 20,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
