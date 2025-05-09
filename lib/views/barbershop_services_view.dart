import 'package:barbermanager_fe/views/BarberChoiceView.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';
import 'package:barbermanager_fe/widgets/BarberServiceCard.dart';
import 'package:barbermanager_fe/models/barber_shop.dart';

class BarbershopServicesView extends StatefulWidget {
  final Barbershop barbershop;

  const BarbershopServicesView({Key? key, required this.barbershop})
    : super(key: key);

  @override
  _BarbershopServicesViewState createState() => _BarbershopServicesViewState();
}

class _BarbershopServicesViewState extends State<BarbershopServicesView> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory =
        widget.barbershop.categories.isNotEmpty
            ? widget.barbershop.categories.first
            : null;
  }

  @override
  Widget build(BuildContext context) {
    final filteredServices =
        widget.barbershop.services.where((service) {
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
          widget.barbershop.name,
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    widget.barbershop.categories.map((category) {
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BarberChoiceView(
                                        team: widget.barbershop.team,
                                        selectedService: service,
                                      ),
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
