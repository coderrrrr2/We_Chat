import 'package:practice_chat_app/features/auth/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

final List<ChangeNotifierProvider> authProvider = [
  ChangeNotifierProvider<AuthProvider>(
    create: (context) => AuthProvider(),
  ),
];
