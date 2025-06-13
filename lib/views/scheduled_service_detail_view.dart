import 'package:barbermanager_fe/view_models/agendamento_service.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/models/barberservice.dart';

class ScheduledServiceDetailView extends StatelessWidget {
  final Servico servico;

  const ScheduledServiceDetailView({super.key, required this.servico});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Agendamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto do profissional
            if (servico.barber.imageUrl.isNotEmpty)
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(servico.barber.imageUrl),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              servico.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Profissional: ${servico.barber.name}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Preço: R\$ ${servico.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (servico.dateTime != null)
              Text(
                'Data: ${servico.dateTime!.day}/${servico.dateTime!.month}/${servico.dateTime!.year} às ${servico.dateTime!.hour.toString().padLeft(2, '0')}:${servico.dateTime!.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 8),
            if (servico.barbershop != null)
              Text(
                'Local: ${servico.barbershop!.name}\nEndereço: ${servico.barbershop!.address}',
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16),
            Text(
              'Descrição: ${servico.description ?? "Sem descrição"}',
              style: const TextStyle(fontSize: 15),
            ),
            const Spacer(),
            // Botões em balões
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Balão Cancelar
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.red[50],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      // Lógica de cancelamento aqui
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cancelar agendamento'),
                          content: const Text('Tem certeza que deseja cancelar este agendamento?'),
                          actions: [
                            TextButton(
                              onPressed: (){

                              },
                              child: const Text('Não'),
                            ),
                            TextButton(
                              onPressed: () {
                                AgendamentoService().removeServico(servico);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Sim', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Row(
                        children: const [
                          Icon(Icons.cancel, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Balão Conversar
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.green[50],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      // Lógica para abrir chat com o profissional
                      Navigator.pushNamed(context, '/chat', arguments: servico.barber);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Row(
                        children: const [
                          Icon(Icons.chat_bubble_outline, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Conversar',
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}