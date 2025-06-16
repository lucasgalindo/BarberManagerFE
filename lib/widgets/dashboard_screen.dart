import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';
import 'package:barbermanager_fe/widgets/barber_drawer.dart';
import 'package:barbermanager_fe/widgets/service_category_manager.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/view_models/dashboard_agendamento_view_model.dart';
import 'package:barbermanager_fe/models/agendamento.dart';

class DashboardCalendar extends StatefulWidget {
  final bool isBarbershopOwner;

  const DashboardCalendar({super.key, required this.isBarbershopOwner});

  @override
  State<DashboardCalendar> createState() => _DashboardCalendarState();
}

class _DashboardCalendarState extends State<DashboardCalendar> {
  late Map<String, dynamic> user;
  DashboardAgendamentoViewModel? dashboardViewModel;
  DashboardViewMode _viewMode = DashboardViewMode.mensal;
  DateTime _focusedDay = DateTime.now();

  static const List<String> _meses = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
  ];

  BoxDecoration get _containerDecoration => BoxDecoration(
    color: const Color.fromRGBO(30, 30, 30, 0.2),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: const Color.fromRGBO(30, 30, 30, 0.5), width: 1),
  );

  @override
  void initState() {
    super.initState();
    _initDashboardViewModel();
  }

  Future<void> _initDashboardViewModel() async {
    final userData = await getUserData();
    if (userData != null) {
      setState(() {
        user = userData['usuario'];
      });
      final userToken = userData['token'] as String;
      final userId = userData['id'].toString();
      setState(() {
        dashboardViewModel = DashboardAgendamentoViewModel(
          isBarbershopOwner: widget.isBarbershopOwner,
          userToken: userToken,
        );
      });
      // await dashboardViewModel!.fetchAgendamentos();
      // setState(() {}); // Atualiza a tela após buscar os dados
    }
  }

  List<Agendamento> _agendamentosDoDia(DateTime day, List<Agendamento> ags) {
    return ags
        .where(
          (a) =>
              a.dateTime.year == day.year &&
              a.dateTime.month == day.month &&
              a.dateTime.day == day.day,
        )
        .toList();
  }

  List<DateTime> _diasComAgendamento(List<Agendamento> ags) {
    return ags
        .map((a) => DateTime(a.dateTime.year, a.dateTime.month, a.dateTime.day))
        .toSet()
        .toList();
  }

  void _showAgendamentoPopup(List<Agendamento> ags, DateTime dia) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF232323),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Agendamentos de ${dia.day.toString().padLeft(2, '0')} de ${_meses[dia.month - 1]}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...ags.map(
                    (ag) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _popupRow("Cliente", ag.cliente.usuario!.nome!),
                          if (widget.isBarbershopOwner &&
                              ag.barber.name.isNotEmpty)
                            _popupRow("Barbeiro", ag.barber.name),
                          _popupRow("Serviço", ag.servico.name),
                          _popupRow(
                            "Preço",
                            "R\$ ${ag.preco.toStringAsFixed(2)}",
                          ),
                          _popupRow(
                            "Horário",
                            "${ag.dateTime.hour.toString().padLeft(2, '0')}:${ag.dateTime.minute.toString().padLeft(2, '0')}",
                          ),
                          if (!widget.isBarbershopOwner &&
                              ag.cliente.usuario!.endereco != null)
                            _popupRow(
                              "Endereço",
                              ag.cliente.usuario!.endereco!,
                            ),
                          if (ags.length > 1 && ag != ags.last)
                            const Divider(color: Colors.white12),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Fechar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _popupRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewModeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _viewModeButton("Diário", DashboardViewMode.diario),
        const SizedBox(width: 8),
        _viewModeButton("Semanal", DashboardViewMode.semanal),
        const SizedBox(width: 8),
        _viewModeButton("Mensal", DashboardViewMode.mensal),
      ],
    );
  }

  Widget _viewModeButton(String label, DashboardViewMode mode) {
    final selected = _viewMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _viewMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color:
              selected
                  ? const Color.fromRGBO(23, 23, 180, 1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color.fromRGBO(23, 23, 180, 1),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar(List<Agendamento> agendamentos) {
    final diasComAgendamento = _diasComAgendamento(agendamentos);

    if (_viewMode == DashboardViewMode.diario) {
      final ags = _agendamentosDoDia(_focusedDay, agendamentos);
      return _buildDayView(_focusedDay, ags);
    }

    if (_viewMode == DashboardViewMode.semanal) {
      final startOfWeek = _focusedDay.subtract(
        Duration(days: _focusedDay.weekday % 7),
      );
      final daysOfWeek = List.generate(
        7,
        (i) => startOfWeek.add(Duration(days: i)),
      );

      return Container(
        decoration: _containerDecoration,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _focusedDay = _focusedDay.subtract(
                        const Duration(days: 7),
                      );
                    });
                  },
                ),
                Text(
                  "Semana de ${startOfWeek.day} ${_meses[startOfWeek.month - 1]}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _focusedDay = _focusedDay.add(const Duration(days: 7));
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: const [
                Expanded(
                  child: Center(
                    child: Text("Dom", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text("Seg", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text("Ter", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text("Qua", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text("Qui", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text("Sex", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text("Sáb", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: List.generate(7, (i) {
                final day = daysOfWeek[i];
                final hasAgendamento = diasComAgendamento.contains(
                  DateTime(day.year, day.month, day.day),
                );
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final ags = _agendamentosDoDia(day, agendamentos);
                      if (ags.isNotEmpty) {
                        _showAgendamentoPopup(ags, day);
                      }
                    },
                    child: Container(
                      decoration: _containerDecoration.copyWith(
                        border:
                            hasAgendamento
                                ? Border.all(
                                  color: const Color.fromRGBO(23, 23, 180, 1),
                                  width: 2,
                                )
                                : _containerDecoration.border,
                      ),
                      width: 32,
                      height: 32,
                      margin: const EdgeInsets.all(1),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
    }

    // MENSAL
    final firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    final int startWeekday = firstDayOfMonth.weekday % 7; // 0=Domingo
    final int totalDays = lastDayOfMonth.day;

    List<Widget> dayWidgets = [];
    for (int i = 0; i < startWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }
    for (int day = 1; day <= totalDays; day++) {
      final currentDay = DateTime(_focusedDay.year, _focusedDay.month, day);
      final hasAgendamento = diasComAgendamento.contains(currentDay);
      dayWidgets.add(
        GestureDetector(
          onTap: () {
            final ags = _agendamentosDoDia(currentDay, agendamentos);
            if (ags.isNotEmpty) {
              _showAgendamentoPopup(ags, currentDay);
            }
          },
          child: Container(
            decoration: _containerDecoration.copyWith(
              border:
                  hasAgendamento
                      ? Border.all(
                        color: const Color.fromRGBO(23, 23, 180, 1),
                        width: 2,
                      )
                      : _containerDecoration.border,
            ),
            width: 28,
            height: 28,
            margin: const EdgeInsets.all(1),
            child: Center(
              child: Text(
                day.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      );
    }
    while (dayWidgets.length % 7 != 0) {
      dayWidgets.add(const SizedBox());
    }

    return Container(
      decoration: _containerDecoration,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month - 1,
                      1,
                    );
                  });
                },
              ),
              Text(
                "${_meses[_focusedDay.month - 1]} ${_focusedDay.year}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month + 1,
                      1,
                    );
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Dom", style: TextStyle(color: Colors.white)),
              Text("Seg", style: TextStyle(color: Colors.white)),
              Text("Ter", style: TextStyle(color: Colors.white)),
              Text("Qua", style: TextStyle(color: Colors.white)),
              Text("Qui", style: TextStyle(color: Colors.white)),
              Text("Sex", style: TextStyle(color: Colors.white)),
              Text("Sáb", style: TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 2),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: dayWidgets,
          ),
        ],
      ),
    );
  }

  Widget _buildDayView(DateTime day, List<Agendamento> agendamentos) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white),
              onPressed: () {
                setState(() {
                  _focusedDay = _focusedDay.subtract(const Duration(days: 1));
                });
              },
            ),
            Text(
              "${day.day} de ${_meses[day.month - 1]}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.white),
              onPressed: () {
                setState(() {
                  _focusedDay = _focusedDay.add(const Duration(days: 1));
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        agendamentos.isEmpty
            ? const Text(
              "Nenhum agendamento para este dia.",
              style: TextStyle(color: Colors.white, fontSize: 14),
            )
            : Column(
              children:
                  agendamentos.map((ag) {
                    return GestureDetector(
                      onTap: () => _showAgendamentoPopup([ag], day),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        decoration: _containerDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ag.servico.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              ag.cliente.usuario!.nome!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (dashboardViewModel == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return AnimatedBuilder(
      animation: dashboardViewModel!,
      builder: (context, _) {
        if (dashboardViewModel!.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (dashboardViewModel!.error != null) {
          return Center(child: Text(dashboardViewModel!.error!));
        }
        final agendamentos = dashboardViewModel!.agendamentos;
        return Scaffold(
          backgroundColor: const Color(0xFF121212),
          drawer: BarberDrawer(
            username: user.isNotEmpty ? user['nome'] : '..',
            imageUrl: null,
            onManageServices: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceCategoryManager(),
                ),
              );
            },
            onLogout: () {},
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Dashboard de Agendamentos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildViewModeSelector(),
                const SizedBox(height: 10),
                _buildCalendar(agendamentos),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum DashboardViewMode { diario, semanal, mensal }
