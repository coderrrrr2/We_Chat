import 'package:flutter/material.dart';

class SessionProvider extends ChangeNotifier {
  bool isLightMode = true;
  void toggleTheme() {
    isLightMode = !isLightMode;
    notifyListeners();
  }
}
