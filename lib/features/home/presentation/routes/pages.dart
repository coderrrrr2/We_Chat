import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:practice_chat_app/features/home/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/home/presentation/view/home_view.dart';

List<GetPage> homePages = [
  GetPage(
      name: HomeRoutes.mainView,
      page: () => const HomeView(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500)),
];
