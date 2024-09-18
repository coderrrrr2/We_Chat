import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/models/chat_model.dart';
import 'package:practice_chat_app/models/message_model.dart';
import 'package:practice_chat_app/models/user_model.dart';

class ChatService {
  Stream<QuerySnapshot<UserProfile>> getUserProfiles() {
    return usersCollection
        ?.where("uid", isNotEqualTo: authService.user!.uid)
        .snapshots() as Stream<QuerySnapshot<UserProfile>>;
  }

  Future<bool> checkIfChatExits(String uuid1, String uuid2) async {
    String chatId = generateChatId(uuid1: uuid1, uuid2: uuid2);
    final result = await chatCollection?.doc(chatId).get();
    if (result != null) {
      return result.exists;
    } else {
      return false;
    }
  }

  Future<void> createNewChat(String uuid1, String uuid2) async {
    String chatId = generateChatId(uuid1: uuid1, uuid2: uuid2);

    final docRef = chatCollection!.doc(chatId);
    final chat = Chat(id: chatId, participantIds: [uuid1, uuid2], messages: []);
    await docRef.set(chat);
  }

  Future<void> sendChatMessage(
      String uuid1, String uuid2, Message message) async {
    String chatId = generateChatId(uuid1: uuid1, uuid2: uuid2);
    final docRef = chatCollection!.doc(chatId);
    await docRef.update({
      'messages': FieldValue.arrayUnion([message.toJson()])
    });
  }

  Stream getMessages(String uuid1, String uuid2) {
    String chatId = generateChatId(uuid1: uuid1, uuid2: uuid2);
    final docRef = chatCollection!.doc(chatId);
    return docRef.snapshots() as Stream<DocumentSnapshot<Chat>>;
  }
}
