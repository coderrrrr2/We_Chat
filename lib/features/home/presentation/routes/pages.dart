import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:practice_chat_app/features/home/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/home/presentation/view/chat_page.dart';
import 'package:practice_chat_app/features/home/presentation/view/home_view.dart';
import 'package:practice_chat_app/features/navigation/auth_middleware.dart';

List<GetPage> homePages = [
  GetPage(
      name: HomeRoutes.mainView,
      page: () => const HomeView(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500),
      middlewares: [
        AuthMiddleware(),
      ]),
  GetPage(
    name: HomeRoutes.chatView,
    page: () => const ChatPage(),
    transition: Transition.native,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];
