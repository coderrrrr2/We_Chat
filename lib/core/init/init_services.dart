import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_chat_app/core/services/auth_service.dart';
import 'package:practice_chat_app/core/services/database_service.dart';
import 'package:practice_chat_app/core/services/storage_service.dart';
import 'package:practice_chat_app/firebase_options.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton(AuthService());
  getIt.registerSingleton(StorageService());
  getIt.registerSingleton(DatabaseService());
}

//service singletons
final GetIt _getIt = GetIt.instance;
final authService = _getIt.get<AuthService>();
final storageService = _getIt.get<StorageService>();
final dataBaseService = _getIt.get<DatabaseService>();
