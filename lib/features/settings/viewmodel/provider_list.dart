import 'package:practice_chat_app/features/settings/viewmodel/session_provider.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> settingsProvider = [
  ChangeNotifierProvider<SessionProvider>(
      create: (context) => SessionProvider()),
];
