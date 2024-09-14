import 'package:get/route_manager.dart';
import 'package:practice_chat_app/features/profile/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/profile/presentation/view/edit_profile_view.dart';
import 'package:practice_chat_app/features/profile/presentation/view/profile_view.dart';

List<GetPage> profilePages = [
  GetPage(
    name: ProfileRoutes.profileView,
    page: () => const ProfileView(),
    transition: Transition.native,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: ProfileRoutes.editProfileView,
    page: () => const EditProfileView(),
    transition: Transition.native,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];
