import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/models/user_model.dart';

class AuthService {
  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  User? get user => _user;

  Future<bool> emailAndPasswordLogin(String email, String password) async {
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

  Future<bool> passwordLessLogin(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url:
              'practice-chat-app-137b8.firebaseapp.com', // Replace with your app's URL
          androidPackageName:
              'com.example.app', // Replace with your Android package name
          handleCodeInApp: true,
          iOSBundleId:
              'com.example.practiceChatApp', // Replace with your iOS bundle ID
        ),
      );
      return true;
    } catch (e) {
      log('Error sending authentication link: $e');

      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        _user = credential.user;
        _user!.sendEmailVerification();
        return true;
      }
    } catch (e) {
      log('Error during login: $e');
    }
    return false;
  }

  Future<bool> createUserProfile(
      {required BuildContext context, required UserProfile userProfile}) async {
    try {
      await usersCollection?.doc(userProfile.uid).set(userProfile);
      return true;
    } catch (e) {
      log(e.toString());

      return false;
    }
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
