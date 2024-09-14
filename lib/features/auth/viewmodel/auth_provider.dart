import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService = AuthService();

  AuthProvider() {
    if (authService.user != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
  }

  bool _isLoading = false;

  bool? isLoggedIn;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> logIn(String email, String password) async {
    try {
      isLoading = true;

      return authService.login(email, password);
    } catch (e) {
      isLoading = false;
      return false;
    } finally {
      isLoading = false;
    }
  }
}
