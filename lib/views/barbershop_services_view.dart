import 'package:barbermanager_fe/view_models/agendamento_service.dart';
import 'package:barbermanager_fe/views/barber_choice_view.dart';
import 'package:flutter/material.dart';
import '../models/barber_shop.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';
import 'package:barbermanager_fe/widgets/BarberServiceCard.dart';

class BarbershopServicesView extends StatefulWidget {

  const BarbershopServicesView({
    Key? key
  }) : super(key: key);

  @override
  _BarbershopServicesViewState createState() => _BarbershopServicesViewState();
}

class _BarbershopServicesViewState extends State<BarbershopServicesView> {
  String? selectedCategory;
  late Barbershop barbershop;
  @override
  void initState() {
    super.initState();
    barbershop = AgendamentoService().barbershop!;
  }

  @override
  Widget build(BuildContext context) {
    final filteredServices =
        barbershop.services.where((service) {
          return selectedCategory == null ||
              service.category == selectedCategory;
        }).toList();

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
        title: Text(
          barbershop.name,
          style: const TextStyle(
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
            // Carrossel de categorias
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    barbershop.categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: BoxOfCarousel(
                          isSelected: selectedCategory == category,
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Lista de serviços filtrados
            Expanded(
              child:
                  filteredServices.isNotEmpty
                      ? ListView.separated(
                        itemCount: filteredServices.length,
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final service = filteredServices[index];
                          return GestureDetector(
                            onTap: () {
                              AgendamentoService().currentService = service;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BarberChoiceView(),
                                ),
                              );
                            },
                            child: BarberServiceCard(
                              title: service.name,
                              description: service.description,
                              price: "R\$ ${service.price.toStringAsFixed(2)}",
                            ),
                          );
                        },
                      )
                      : const Center(
                        child: Text(
                          "Nenhum serviço disponível para esta categoria.",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
