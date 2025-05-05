import 'package:flutter/material.dart';
import '../models/seek_service_model.dart';

class SeekserviceViewModel extends ChangeNotifier {
  SeekserviceModel? _selectedService;

  SeekserviceModel? get selectedService => _selectedService;

  void selectSeekservice(SeekService mode) {
    _selectedService = SeekserviceModel(mode: mode);
    notifyListeners();
  }

  void goToMainScreen(BuildContext context) {
    if (_selectedService == null) return;
    switch (_selectedService!.mode) {
      case SeekService.barbeiros:
        Navigator.pushNamed(
          context,
          '/main',
          arguments: {"search": "barbeiros"},
        );
        break;
      case SeekService.barbearias:
        Navigator.pushNamed(
          context,
          '/main',
          arguments: {"search": "barbearias"},
        );
        break;
    }
  }
}
