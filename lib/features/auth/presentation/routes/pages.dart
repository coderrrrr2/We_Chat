import 'package:get/route_manager.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/auth/presentation/view/login_view.dart';
import 'package:practice_chat_app/features/auth/presentation/view/register_view.dart';

List<GetPage> authPages = [
  GetPage(
      name: AuthRoutes.login,
      page: () => const LoginView(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: AuthRoutes.register,
      page: () => const RegisterView(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500)),
];
