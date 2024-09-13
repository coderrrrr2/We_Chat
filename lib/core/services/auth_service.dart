import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Private static instance
  static final AuthService _instance = AuthService._internal();

  // Private constructor
  AuthService._internal() {
    _auth = FirebaseAuth.instance;
  }

  // Factory constructor to return the single instance
  factory AuthService() {
    return _instance;
  }

  late FirebaseAuth _auth;
  User? _user;

  User? get user => _user;

  Future<bool> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        _user = credential.user;
        return true;
      }
    } catch (e) {
      log('Error during login: $e');
    }
    return false;
  }
}
