import 'package:flutter/material.dart';
import 'primary_button.dart';

class ServiceCategoryManager extends StatefulWidget {
  final void Function(List<Category>)? onChanged;

  const ServiceCategoryManager({super.key, this.onChanged});

  @override
  State<ServiceCategoryManager> createState() => _ServiceCategoryManagerState();
}

class Category {
  final String name;
  final List<Service> services;

  Category({required this.name, List<Service>? services})
    : services = services ?? [];
}

class Service {
  final String name;
  final String description;
  final double price;

  Service({required this.name, required this.description, required this.price});
}

class _ServiceCategoryManagerState extends State<ServiceCategoryManager> {
  final List<Category> _categories = [];

  void _addCategory(String name) {
    setState(() {
      _categories.add(Category(name: name));
    });
    widget.onChanged?.call(_categories);
  }

  void _addService(int categoryIndex, Service service) {
    setState(() {
      _categories[categoryIndex].services.add(service);
    });
    widget.onChanged?.call(_categories);
  }

  void _editService(int categoryIndex, int serviceIndex, Service updated) {
    setState(() {
      _categories[categoryIndex].services[serviceIndex] = updated;
    });
    widget.onChanged?.call(_categories);
  }

  void _deleteService(int categoryIndex, int serviceIndex) {
    setState(() {
      _categories[categoryIndex].services.removeAt(serviceIndex);
    });
    widget.onChanged?.call(_categories);
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: const Color.fromRGBO(30, 30, 30, 0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromRGBO(30, 30, 30, 0.5),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromRGBO(30, 30, 30, 0.5),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromRGBO(23, 23, 180, 1),
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _popupActionButton({
    required String text,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return SizedBox(
      width: 140,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isPrimary
                  ? const Color.fromRGBO(23, 23, 180, 1)
                  : const Color.fromRGBO(30, 30, 30, 0.2),
          foregroundColor: isPrimary ? Colors.white : Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side:
                isPrimary
                    ? BorderSide.none
                    : const BorderSide(color: Colors.red, width: 1.5),
          ),
          elevation: 0,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  void _showAddCategoryDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Adicionar Categoria",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller,
                    decoration: _inputDecoration("Nome da categoria"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _popupActionButton(
                        text: "Cancelar",
                        isPrimary: false,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      _popupActionButton(
                        text: "Adicionar",
                        isPrimary: true,
                        onPressed: () {
                          final name = controller.text.trim();
                          if (name.isNotEmpty) {
                            _addCategory(name);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showAddServiceDialog(int categoryIndex) {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    final priceController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Adicionar Serviço",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: _inputDecoration("Nome do serviço"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descController,
                    decoration: _inputDecoration("Descrição"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: _inputDecoration("Preço"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _popupActionButton(
                        text: "Cancelar",
                        isPrimary: false,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      _popupActionButton(
                        text: "Adicionar",
                        isPrimary: true,
                        onPressed: () {
                          final name = nameController.text.trim();
                          final desc = descController.text.trim();
                          final price =
                              double.tryParse(
                                priceController.text.replaceAll(',', '.'),
                              ) ??
                              0.0;
                          if (name.isNotEmpty && price > 0) {
                            _addService(
                              categoryIndex,
                              Service(
                                name: name,
                                description: desc,
                                price: price,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showEditServiceDialog(int categoryIndex, int serviceIndex) {
    final service = _categories[categoryIndex].services[serviceIndex];
    final nameController = TextEditingController(text: service.name);
    final descController = TextEditingController(text: service.description);
    final priceController = TextEditingController(
      text: service.price.toStringAsFixed(2),
    );
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Editar Serviço",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: _inputDecoration("Nome do serviço"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descController,
                    decoration: _inputDecoration("Descrição"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: _inputDecoration("Preço"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _popupActionButton(
                        text: "Cancelar",
                        isPrimary: false,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      _popupActionButton(
                        text: "Atualizar",
                        isPrimary: true,
                        onPressed: () {
                          final name = nameController.text.trim();
                          final desc = descController.text.trim();
                          final price =
                              double.tryParse(
                                priceController.text.replaceAll(',', '.'),
                              ) ??
                              0.0;
                          if (name.isNotEmpty && price > 0) {
                            _editService(
                              categoryIndex,
                              serviceIndex,
                              Service(
                                name: name,
                                description: desc,
                                price: price,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Você não possui categorias adicionadas",
            style: TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: "Adicionar Categoria",
            onPressed: _showAddCategoryDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        ..._categories.asMap().entries.map((entry) {
          final idx = entry.key;
          final category = entry.value;
          return Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(30, 30, 30, 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color.fromRGBO(30, 30, 30, 0.5),
                width: 1,
              ),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  category.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Color.fromRGBO(23, 23, 180, 1),
                  ),
                  tooltip: "Adicionar serviço",
                  onPressed: () => _showAddServiceDialog(idx),
                ),
                children:
                    category.services.isEmpty
                        ? [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Nenhum serviço cadastrado.",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        ]
                        : category.services.asMap().entries.map((serviceEntry) {
                          final sIdx = serviceEntry.key;
                          final service = serviceEntry.value;
                          return InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => _showEditServiceDialog(idx, sIdx),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(30, 30, 30, 0.2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color.fromRGBO(30, 30, 30, 0.5),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          service.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        if (service.description.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4.0,
                                            ),
                                            child: Text(
                                              service.description,
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4.0,
                                          ),
                                          child: Text(
                                            "R\$ ${service.price.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      tooltip: "Excluir serviço",
                                      onPressed:
                                          () => _deleteService(idx, sIdx),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
              ),
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: "Voltar",
                ),
              ),
              const Center(
                child: Text(
                  "Categorias de Serviços",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_categories.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Color.fromRGBO(23, 23, 180, 1),
                      size: 28,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    tooltip: "Adicionar categoria",
                    onPressed: _showAddCategoryDialog,
                  ),
                ),
            ],
          ),
        ),
      ),
      body: _categories.isEmpty ? _buildEmptyState() : _buildCategoryList(),
    );
  }
}
