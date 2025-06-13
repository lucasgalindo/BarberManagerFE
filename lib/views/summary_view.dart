import 'package:flutter/material.dart';
import 'package:barbermanager_fe/view_models/agendamento_service.dart';
import 'package:barbermanager_fe/widgets/primary_button.dart';
import 'package:barbermanager_fe/widgets/InfoBox.dart';

class SummaryView extends StatefulWidget {
  SummaryView({super.key});
  final AgendamentoService data = AgendamentoService();

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> with SingleTickerProviderStateMixin {
  bool showSuccess = false;
  bool showCheck = false;

  void _finalizar() async {
    AgendamentoService().confirmarAgendamentos(); // <-- Adicione esta linha

    setState(() => showSuccess = true);
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() => showCheck = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/agendamentos', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Stack(
      children: [
        Scaffold(
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
              "Resumo do Agendamento",
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
                // Caixa Cliente
                const SizedBox(height: 8),

                // Caixa Local
                InfoBox(
                  title: "Local",
                  children: [
                    Text(
                      data.barbershop!.address,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.barbershop!.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Caixa Data e Hora
                // InfoBox(
                //   title: "Data e Hora",
                //   children:
                //       data.agendamentos.map((service) {
                //         return Text(
                //           "${service.dateTime!.toIso8601String().split("T")[0]} às ${service.dateTime!.toIso8601String().split("T")[1].substring(0, 5)}",
                //           style: const TextStyle(
                //             color: Colors.white,
                //             fontSize: 14,
                //             fontWeight: FontWeight.w300,
                //           ),
                //         );
                //       }).toList(),
                // ),
                const SizedBox(height: 8),

                // Caixa Contato da Barbearia
                InfoBox(
                  title: "Contato da Barbearia",
                  children: [
                    Text(
                      data.barbershop!.phone,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Separador
                const Divider(color: Colors.white70, thickness: 1),
                const SizedBox(height: 24),

                // Caixa Serviços
                InfoBox(
                  title: "Serviço(s)",
                  children:
                      data.agendamentos.map((service) {
                        return Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Profissional: ${service.barber.name}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
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
                        "R\$ ${data.getTotalPrice().toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  text: "Finalizar",
                  onPressed: _finalizar,
                ),
              ],
            ),
          ),
        ),
        // Tela branca animada
        if (showSuccess)
          AnimatedOpacity(
            opacity: showSuccess ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: AnimatedScale(
                  scale: showCheck ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 120,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}