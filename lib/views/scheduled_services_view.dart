import 'package:barbermanager_fe/models/finalAgendamento.dart';
import 'package:barbermanager_fe/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/view_models/agendamento_service.dart';

class ScheduledServicesView extends StatefulWidget {
  const ScheduledServicesView({super.key});

  @override
  State<ScheduledServicesView> createState() => _ScheduledServicesViewState();
}

class _ScheduledServicesViewState extends State<ScheduledServicesView> {
  final AgendamentoService agendamentoService = AgendamentoService();
  List<FinalAgendamento> agendamentos = [];
  void _showAgendamentoPopup(BuildContext context, FinalAgendamento servico) {
    final dateTime = servico.dataHorario;
    String dateStr =
        dateTime != null
            ? "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}"
            : "--/--/----";
    String timeStr =
        dateTime != null
            ? "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}"
            : "--:--";

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: Color.fromRGBO(30, 30, 30, 0.5),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    servico.tipoServico,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Profissional: ${servico.barbeiroNome ?? ""}",
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Data: $dateStr",
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Horário: $timeStr",
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Preço: R\$ ${servico.price.toStringAsFixed(2) ?? ""}",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  
                  const SizedBox(height: 16),
                  // ...existing code...
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await UserRepository.instance.cancelarAgendamento(servico.id);
                            await _awaitrequest();
                            setState(() {
                            Navigator.pop(context);
                            });
                          },
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: const Color.fromRGBO(
                              23,
                              23,
                              180,
                              1,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Color.fromRGBO(23, 23, 180, 1),
                                width: 1.5,
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Fechar",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ...existing code...
                ],
              ),
            ),
          ),
    );
  }
  
  @override
  void initState() {
    super.initState();
    _awaitrequest();
  }

  Future<void> _awaitrequest() async{
       final agendamentoMaps = await UserRepository.instance.getAgendamentos();
     setState((){
    agendamentos = agendamentoMaps.map<FinalAgendamento>((map) {
      return FinalAgendamento.fromJson(map);
    }).toList();
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Agendamentos'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          },
        ),
      ),
      body:
          agendamentos.isEmpty
              ? const Center(
                child: CircularProgressIndicator(),
              )
              : ListView.builder(
                itemCount: agendamentos.length,
                itemBuilder: (context, index) {
                  final servico = agendamentos[index];
                  final dateTime = servico.dataHorario;
                  String dateStr =
                      dateTime != null
                          ? "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}"
                          : "--/--/----"; 
                  String timeStr =
                      dateTime != null
                          ? "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}"
                          : "--:--";
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color.fromRGBO(30, 30, 30, 0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          color: Color.fromRGBO(30, 30, 30, 0.5),
                          width: 1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.event_note,
                        color: Colors.white,
                      ),
                      title: Text(
                        servico.tipoServico,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (servico.dataHorario != null)
                            Text(
                              'Profissional: ${servico.barbeiroNome}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          Text(
                            'Data: $dateStr',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'Horário: $timeStr',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      onTap: () => _showAgendamentoPopup(context, servico),
                    ),
                  );
                },
              ),
    );
  }
}
