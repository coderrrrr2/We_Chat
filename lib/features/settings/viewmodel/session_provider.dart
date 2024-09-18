import 'package:flutter/material.dart';

class SessionProvider extends ChangeNotifier {
  bool isLightMode = true;

  void updateModeStatus(bool value) {
    isLightMode = value;
    notifyListeners();
  }
}
