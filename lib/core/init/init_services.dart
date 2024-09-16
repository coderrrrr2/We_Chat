import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_chat_app/core/services/auth_service.dart';
import 'package:practice_chat_app/core/services/storage_service.dart';
import 'package:practice_chat_app/firebase_options.dart';
import 'package:practice_chat_app/models/chat_model.dart';
import 'package:practice_chat_app/models/user_model.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton(AuthService());
  getIt.registerSingleton(StorageService());

  _setupCollectionReferences();
}

//service singletons
final GetIt _getIt = GetIt.instance;
final authService = _getIt.get<AuthService>();
final storageService = _getIt.get<StorageService>();

String generateChatId({required String uuid1, required String uuid2}) {
  final List<String> uuids = [uuid1, uuid2];
  uuids.sort();
  return uuids.fold(
    '',
    (id, uuid) => "$id$uuid",
  );
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

CollectionReference? usersCollection;
CollectionReference? chatCollection;

void _setupCollectionReferences() {
  usersCollection = _firestore.collection('users').withConverter<UserProfile>(
    fromFirestore: (snapshot, _) {
      return UserProfile.fromJson(snapshot.data()!);
    },
    toFirestore: (user, _) {
      return user.toJson();
    },
  );
  chatCollection = _firestore.collection('chats').withConverter<Chat>(
      fromFirestore: (snapshot, _) {
    return Chat.fromJson(snapshot.data()!);
  }, toFirestore: (chat, _) {
    return chat.toJson();
  });
}
