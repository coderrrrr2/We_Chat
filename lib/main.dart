import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:practice_chat_app/features/navigation/all_pages.dart';

void main() async {
  await setupFirebase();
  runApp(const MainApp());
}

Future<void> setupFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.initial,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
    );
  }
}
