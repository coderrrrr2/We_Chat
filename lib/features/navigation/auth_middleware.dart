import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_chat_app/core/services/auth_service.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/home/presentation/routes/routes.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthService authService = AuthService();

  // @override
  // RouteSettings? redirect(String? route) {
  //   if (authService.user != null) {
  //     return const RouteSettings(name: HomeRoutes.mainView);
  //   } else {
  //     return const RouteSettings(name: AuthRoutes.login);
  //   }
  // }
}
