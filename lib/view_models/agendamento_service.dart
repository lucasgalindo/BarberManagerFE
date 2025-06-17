import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/repositories/user_repository.dart';
import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';

class AgendamentoService {
  Barbershop? barbershop;
  DateTime? selectedDate;
  final List<Servico> _agendamentos = [];
  List<Servico> get agendamentos => _agendamentos;

  final List<Servico> _agendamentosConfirmados = [];
  List<Servico> get agendamentosConfirmados => _agendamentosConfirmados;

  late BarberService currentService;
  Barber? currentBarber;
  get currentServiceInfo => currentService;

  final Map<Servico, List<String>> availableTimesPerService = {};
  final Map<Servico, String?> selectedTimePerService = {};
  final Map<Servico, bool> showTimesPerService = {};
  final Map<Servico, DateTime?> selectedDatePerService = {};

  add(Servico servico) {
    _agendamentos.add(servico);
    availableTimesPerService[servico] = [];
    selectedTimePerService[servico] = null;
    showTimesPerService[servico] = false;
    selectedDatePerService[servico] = null;
  }

  remove(int id) {
    final servico = _agendamentos[id];
    _agendamentos.removeAt(id);
    availableTimesPerService.remove(servico);
    selectedTimePerService.remove(servico);
    showTimesPerService.remove(servico);
    selectedDatePerService.remove(servico);
  }

  removeLast() {
    if (_agendamentos.isNotEmpty) {
      final servico = _agendamentos.last;
      _agendamentos.removeLast();
      availableTimesPerService.remove(servico);
      selectedTimePerService.remove(servico);
      showTimesPerService.remove(servico);
      selectedDatePerService.remove(servico);
    }
  }

  addBarbershop(Barbershop barbershop) {
    this.barbershop = barbershop;
  }

  AgendamentoService._privateConstructor();
  static final AgendamentoService _instance =
      AgendamentoService._privateConstructor();
  factory AgendamentoService() {
    return _instance;
  }

  getTotalPrice() {
    double total = 0.0;
    for (var servico in _agendamentos) {
      total += servico.price;
    }
    return total;
  }

  addBarber(Barber barber) {
    currentBarber = barber;
    var currentAgendamento = Servico(
      barberautonomos: null,
      name: currentService.name,
      description: currentService.name,
      barber: currentBarber!,
      price: currentService.price,
      barbershop: barbershop,
    );
    add(currentAgendamento);
  }

  /// Retorna uma lista de datas disponíveis para agendamento (próximos 7 dias, apenas dias em que a barbearia está aberta)
  List<DateTime> getAvailableDates() {
    final now = DateTime.now();
    List<DateTime> availableDates = [];
    if (barbershop == null) return availableDates;
    for (int i = 0; i < 7; i++) {
      final date = now.add(Duration(days: i));
      final weekdayName =
          [
            "Domingo",
            "Segunda",
            "Terça",
            "Quarta",
            "Quinta",
            "Sexta",
            "Sábado",
          ][date.weekday % 7];
      final workingHours = barbershop!.workingHours[weekdayName];
      if (workingHours != null && workingHours != "Fechado") {
        availableDates.add(date);
      }
    }
    return availableDates;
  }

  /// Retorna horários disponíveis para um barbeiro em uma data específica, bloqueando horários já reservados e horários já selecionados na sessão
  List<String> getAvailableTimesForBarber(
    Barber barber,
    DateTime date, [
    Servico? servicoAtual,
  ]) {
    final selectedTimes =
        selectedTimePerService.entries
            .where(
              (entry) =>
                  entry.key.barber == barber &&
                  (servicoAtual == null || entry.key != servicoAtual) &&
                  selectedDatePerService[entry.key]?.year == date.year &&
                  selectedDatePerService[entry.key]?.month == date.month &&
                  selectedDatePerService[entry.key]?.day == date.day,
            )
            .map((entry) => entry.value)
            .whereType<String>()
            .toSet();

    return barber.availableTimes.where((time) {
      final isReserved = barber.reservedTimes.any(
        (dt) =>
            dt.year == date.year &&
            dt.month == date.month &&
            dt.day == date.day &&
            dt.hour == int.parse(time.split(':')[0]) &&
            dt.minute == int.parse(time.split(':')[1]),
      );
      return !isReserved && !selectedTimes.contains(time);
    }).toList();
  }

  Map<Barber, List<String>> getAvailableTimesForDate(DateTime date) {
    if (barbershop == null) return {};
    Map<Barber, List<String>> result = {};
    for (var barber in barbershop!.team) {
      result[barber] = getAvailableTimesForBarber(barber, date);
    }
    return result;
  }

  void prepareTimesForService(Servico servico, DateTime selectedDate) {
    final times = getAvailableTimesForBarber(
      servico.barber!,
      selectedDate,
      servico,
    );
    availableTimesPerService[servico] = times;
    showTimesPerService[servico] = true;
    selectedTimePerService[servico] ??= null;
    selectedDatePerService[servico] = selectedDate;
  }

  void selectTimeForService(Servico servico, String? time) {
    selectedTimePerService[servico] = time;
  }

  void hideTimesForService(Servico servico) {
    showTimesPerService[servico] = false;
  }

  removeServico(Servico servico) {
    _agendamentos.remove(servico);
    availableTimesPerService.remove(servico);
    selectedTimePerService.remove(servico);
    showTimesPerService.remove(servico);
    selectedDatePerService.remove(servico);
  }

  void confirmarAgendamentos() async {
    for (var servico in _agendamentos) {
      final selectedDate = selectedDatePerService[servico];
      final selectedTime = selectedTimePerService[servico];
      if (selectedDate != null && selectedTime != null) {
        final parts = selectedTime.split(':');
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        servico.dateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          hour,
          minute,
        );
        final barber = servico.barber;

        // Só adiciona se ainda não existe para essa data/hora
        if (!barber!.reservedTimes.any(
          (dt) =>
              dt.year == servico.dateTime!.year &&
              dt.month == servico.dateTime!.month &&
              dt.day == servico.dateTime!.day &&
              dt.hour == servico.dateTime!.hour &&
              dt.minute == servico.dateTime!.minute,
        )) {
          barber!.reservedTimes.add(servico.dateTime!);
        }
      }
    }
    var user = await getUserData();
    agendamentos.forEach(
      (schedule) => {
        UserRepository.instance.MakeScheduling(
          schedule.dateTime!.toIso8601String(),
          schedule.barber?.name ?? schedule.barberautonomos!.name,
          user!["usuario"]["nome"],
          schedule.name,
          user!["usuario"]["endereco"],
        ),
      },
    );
    _agendamentosConfirmados.addAll(_agendamentos);
    _agendamentos.clear();
    availableTimesPerService.clear();
    selectedTimePerService.clear();
    showTimesPerService.clear();
    selectedDatePerService.clear();
  }
}

class Servico {
  DateTime? dateTime;
  final String name;
  final String description;
  final Barber? barber;
  final double price;
  final Barberautonomos? barberautonomos;
  final Barbershop? barbershop;

  Servico({
    this.dateTime,
    required this.name,
    required this.description,
    required this.barber,
    required this.price,
    required this.barberautonomos,
    required this.barbershop,
  });
}
