import 'package:get/route_manager.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/pages.dart';
import 'package:practice_chat_app/features/home/presentation/routes/pages.dart';
import 'package:practice_chat_app/features/home/presentation/routes/routes.dart';

class AppPages {
  static const initial = HomeRoutes.mainView;
  static final List<GetPage> pages = [...authPages, ...homePages];
}
