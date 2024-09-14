import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (authService.user == null) {
      return const RouteSettings(name: AuthRoutes.login);
    }
    return null;
  }
}
