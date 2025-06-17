import 'package:barbermanager_fe/models/barber.dart';
import 'package:barbermanager_fe/models/barber_shop.dart';
import 'package:barbermanager_fe/models/barberservice.dart';
import 'package:barbermanager_fe/models/customer.dart';

class AgendamentoService {
  Barbershop? barbershop;
  DateTime? selectedDate;
  final List<Servico> _agendamentos = [];
  List<Servico> get agendamentos => _agendamentos;

<<<<<<< Updated upstream
  final List<Servico> _agendamentosConfirmados = []; // NOVO
  List<Servico> get agendamentosConfirmados => _agendamentosConfirmados;
=======
    final List<Servico> _agendamentosConfirmados = []; 
    List<Servico> get agendamentosConfirmados => _agendamentosConfirmados;
>>>>>>> Stashed changes

  late BarberService currentService;
  Barber? currentBarber;
  get currentServiceInfo => currentService;

  final Map<Servico, List<String>> availableTimesPerService = {};
  final Map<Servico, String?> selectedTimePerService = {};
  final Map<Servico, bool> showTimesPerService = {};

  add(Servico servico) {
    _agendamentos.add(servico);
  }

  remove(int id) {
    _agendamentos.removeAt(id);
  }

  removeLast() {
    _agendamentos.removeLast();
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
      name: currentService.name,
      description: currentService.name,
      barber: currentBarber!,
      price: currentService.price,
      barbershop: barbershop,
    );
    add(currentAgendamento);
  }

  /// Retorna uma lista de datas disponíveis para agendamento (próximos 7 dias, exceto domingos)
  List<DateTime> getAvailableDates() {
    final now = DateTime.now();
    List<DateTime> availableDates = [];
    for (int i = 0; i < 7; i++) {
      final date = now.add(Duration(days: i));
      // Exemplo: não permite agendamento aos domingos
      if (date.weekday != DateTime.sunday) {
        availableDates.add(date);
      }
    }
    return availableDates;
  }

  /// Retorna horários disponíveis para um barbeiro em uma data específica
  List<String> getAvailableTimesForBarber(Barber barber, DateTime date) {
    // Horários já selecionados para outros serviços nesta data
    final selectedTimes =
        selectedTimePerService.entries
            .where(
              (entry) =>
                  entry.key.barber == barber &&
                  entry.key != currentService && // Não filtra o próprio serviço
                  selectedDate != null &&
                  selectedDate!.year == date.year &&
                  selectedDate!.month == date.month &&
                  selectedDate!.day == date.day,
            )
            .map((entry) => entry.value)
            .whereType<String>()
            .toSet();

    // Retorna apenas horários disponíveis e não selecionados em outro serviço
    return barber.availableTimes
        .where((time) => !barber.reservedTimes.contains(time))
        .where((time) => !selectedTimes.contains(time))
        .toList();
  }

  /// Retorna horários disponíveis para todos barbeiros em uma data específica
  Map<Barber, List<String>> getAvailableTimesForDate(DateTime date) {
    if (barbershop == null) return {};
    Map<Barber, List<String>> result = {};
    for (var barber in barbershop!.team) {
      result[barber] = getAvailableTimesForBarber(barber, date);
    }
    return result;
  }

  // Chame este método ao clicar no serviço
  void prepareTimesForService(Servico servico, DateTime selectedDate) {
    final times = getAvailableTimesForBarber(servico.barber, selectedDate);
    availableTimesPerService[servico] = times;
    showTimesPerService[servico] = true;
    selectedTimePerService[servico] ??= null;
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
  }

  void confirmarAgendamentos() {
    _agendamentosConfirmados.addAll(_agendamentos);
    _agendamentos.clear();
    availableTimesPerService.clear();
    selectedTimePerService.clear();
    showTimesPerService.clear();
  }
}

class Servico {
  final DateTime? dateTime;
  final String name;
  final String description;
  final Barber barber;
  final double price;
  final Barbershop? barbershop;

  const Servico({
    this.dateTime,
    required this.name,
    required this.description,
    required this.barber,
    required this.price,
    required this.barbershop,
  });
}
