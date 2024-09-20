import 'package:get/route_manager.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/auth/presentation/view/choose_login_type_view.dart';
import 'package:practice_chat_app/features/auth/presentation/view/email_and_password_login.dart';
import 'package:practice_chat_app/features/auth/presentation/view/paswordless_login.dart';
import 'package:practice_chat_app/features/auth/presentation/view/register_view.dart';

List<GetPage> authPages = [
  GetPage(
      name: AuthRoutes.passwordLessLogin,
      page: () => const PaswordlessLoginView(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: AuthRoutes.loginWithEmailAndPassword,
      page: () => const LogInWithEmailAndPasswordView(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: AuthRoutes.register,
      page: () => const RegisterView(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: AuthRoutes.chooseLoginView,
      page: () => const ChooseLoginTypeView(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500)),
];
