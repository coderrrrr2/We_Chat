import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
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

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  set errorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> emailAndPasswordLogin(String email, String password) async {
    try {
      isLoading = true;

      return await authService.emailAndPasswordLogin(email, password);
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<bool> passwordLessLogin(String email) async {
    try {
      isLoading = true;

      return await authService.passwordLessLogin(email);
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();

      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      isLoading = true;

      return await authService.signUp(email, password);
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();

      return false;
    }
  }

  Future<bool> createUserProfile(
      BuildContext context, UserProfile userprofile) async {
    try {
      isLoading = true;

      return await authService.createUserProfile(
        context: context,
        userProfile: userprofile,
      );
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();

      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<String?> uploadUserProfilePicture(
      {required File file, required String uid}) async {
    try {
      isLoading = true;

      return await storageService.uploadUserProfilePicture(
          file: file, uid: authService.user!.uid);
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();

      return null;
    }
  }
}
