import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/features/auth/viewmodel/provider_list.dart';
import 'package:practice_chat_app/features/home/viewmodel/providers_list.dart';
import 'package:practice_chat_app/features/navigation/all_pages.dart';
import 'package:provider/provider.dart';

void main() async {
  await setup();
  runApp(MultiProvider(
      providers: [...authProvider, ...homeProvider], child: const MainApp()));
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
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppPages.initial,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
    );
  }
}
