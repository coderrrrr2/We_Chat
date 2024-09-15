import 'package:practice_chat_app/features/home/viewmodel/chat_viewmodel.dart';
import 'package:provider/provider.dart';

final List<ChangeNotifierProvider> homeProvider = [
  ChangeNotifierProvider(create: (context) => ChatViewmodel())
];
