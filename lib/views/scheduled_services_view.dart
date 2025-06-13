import 'package:barbermanager_fe/views/scheduled_service_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/view_models/agendamento_service.dart';

class ScheduledServicesView extends StatefulWidget {
  const ScheduledServicesView({super.key});

  @override
  State<ScheduledServicesView> createState() => _ScheduledServicesViewState();
}

class _ScheduledServicesViewState extends State<ScheduledServicesView> {
  final AgendamentoService agendamentoService = AgendamentoService();

  @override
  Widget build(BuildContext context) {
    final agendamentos = agendamentoService.agendamentosConfirmados;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Agendamentos'),
        centerTitle: true,
      ),
      body: agendamentos.isEmpty
          ? const Center(
              child: Text(
                'Nenhum serviço agendado.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: agendamentos.length,
              itemBuilder: (context, index) {
                final servico = agendamentos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.event_note),
                    title: Text(servico.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Profissional: ${servico.barber.name}'),
                        if (servico.dateTime != null)
                          Text(
                            'Data: ${servico.dateTime!.day}/${servico.dateTime!.month}/${servico.dateTime!.year} às ${servico.dateTime!.hour.toString().padLeft(2, '0')}:${servico.dateTime!.minute.toString().padLeft(2, '0')}',
                          ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ScheduledServiceDetailView(servico: servico),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}