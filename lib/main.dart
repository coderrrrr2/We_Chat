import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/core/theme_data.dart';
import 'package:practice_chat_app/features/auth/viewmodel/provider_list.dart';
import 'package:practice_chat_app/features/home/viewmodel/providers_list.dart';
import 'package:practice_chat_app/features/navigation/all_pages.dart';
import 'package:practice_chat_app/features/navigation/viewmodel/provider_list.dart';
import 'package:practice_chat_app/features/settings/viewmodel/provider_list.dart';
import 'package:practice_chat_app/features/settings/viewmodel/session_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await setup();
  runApp(MultiProvider(providers: [
    ...authProvider,
    ...homeProvider,
    ...navigatorProviders,
    ...settingsProvider
  ], child: const MainApp()));
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerServices();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = context.watch<SessionProvider>();
    return GetMaterialApp(
      theme: sessionProvider.isLightMode ? lightTheme() : darkTheme(),
      initialRoute: AppPages.initial,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
    );
  }
}
