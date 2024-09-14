import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:practice_chat_app/features/home/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/home/presentation/view/chat_page.dart';
import 'package:practice_chat_app/features/home/presentation/view/home_view.dart';
import 'package:practice_chat_app/features/navigation/auth_middleware.dart';
import 'package:practice_chat_app/features/navigation/presentation/view/home_screen_base.dart';

List<GetPage> homePages = [
  GetPage(
      name: HomeRoutes.baseView,
      page: () => const HomeScreenBase(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500),
      middlewares: [
        AuthMiddleware(),
      ]),
  GetPage(
    name: HomeRoutes.mainView,
    page: () => const HomeView(),
    transition: Transition.native,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: HomeRoutes.chatView,
    page: () => ChatPage(
      args: Get.arguments as ChatPageArgs,
    ),
    transition: Transition.native,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];
