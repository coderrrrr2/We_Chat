import 'package:get/route_manager.dart';
import 'package:practice_chat_app/features/settings/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/settings/presentation/view/profile_view.dart';
import 'package:practice_chat_app/features/settings/presentation/view/settings_view.dart';

List<GetPage> settingsPages = [
  GetPage(
    name: SettingsRoutes.profileView,
    page: () => const ProfileView(),
    transition: Transition.native,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: SettingsRoutes.settingsView,
    page: () => const SettingsView(),
    transition: Transition.native,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];
