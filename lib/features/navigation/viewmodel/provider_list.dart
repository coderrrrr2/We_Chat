import 'package:practice_chat_app/features/navigation/viewmodel/bottom_navbar_provider.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> navigatorProviders = [
  ChangeNotifierProvider<BottomNavbarProvider>(
    create: (_) => BottomNavbarProvider(),
  ),
];
