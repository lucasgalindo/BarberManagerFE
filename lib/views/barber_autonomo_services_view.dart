import 'package:barbermanager_fe/views/barber_autonomo_date_time_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:barbermanager_fe/models/barberAutonomos.dart';
import 'package:barbermanager_fe/widgets/box_of_carousel.dart';
import 'package:barbermanager_fe/widgets/BarberServiceCard.dart';

class BarberAutonomoServicesView extends StatefulWidget {
  final Barberautonomos barber;

  const BarberAutonomoServicesView({Key? key, required this.barber})
      : super(key: key);

  @override
  State<BarberAutonomoServicesView> createState() =>
      _BarberAutonomoServicesViewState();
}

class _BarberAutonomoServicesViewState
    extends State<BarberAutonomoServicesView> {
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.barber.categories.isNotEmpty) {
      selectedCategory = widget.barber.categories.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.barber.categories;

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
          widget.barber.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carrossel de categorias
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: BoxOfCarousel(
                      isSelected: selectedCategory == category,
                      child: Text(
                        category.name,
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
              child: selectedCategory != null &&
                      selectedCategory!.services.isNotEmpty
                  ? ListView.separated(
                      itemCount: selectedCategory!.services.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final service = selectedCategory!.services[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BarberAutonomoDateTimeSelectionView(
                                  barber: widget.barber,
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