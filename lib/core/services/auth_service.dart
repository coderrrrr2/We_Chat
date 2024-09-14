import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<bool> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
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

  // Optional: Method to handle logout
  Future<bool> logout() async {
    try {
      await _auth.signOut();
      _user = null;
      return true;
    } catch (e) {
      log('Error during logout: $e');
      return false;
    }
  }
}
