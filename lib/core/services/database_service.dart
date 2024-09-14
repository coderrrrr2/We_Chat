import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/models/chat_model.dart';
import 'package:practice_chat_app/models/user_model.dart';
import 'package:practice_chat_app/shared/utils/app_alert.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? _usersCollection;
  CollectionReference? _chatCollection;

  DatabaseService() {
    _setupCollectionReferences();
  }

  void _setupCollectionReferences() {
    _usersCollection =
        _firestore.collection('users').withConverter<UserProfile>(
      fromFirestore: (snapshot, _) {
        return UserProfile.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
    _chatCollection = _firestore.collection('chats').withConverter<Chat>(
        fromFirestore: (snapshot, _) {
      return Chat.fromJson(snapshot.data()!);
    }, toFirestore: (chat, _) {
      return chat.toJson();
    });
  }

  Future<bool> createUserProfile(
      {required BuildContext context, required UserProfile userProfile}) async {
    try {
      await _usersCollection?.doc(userProfile.uid).set(userProfile).then(
        (value) {
          AppAlert.showToast(context,
              icon: Icons.mark_chat_read,
              message: "User registered Succesfully");
        },
      );

      return true;
    } catch (e) {
      log(e.toString());
      AppAlert.showToast(context,
          icon: Icons.mark_chat_read, message: e.toString());
      return false;
    }
  }

  Stream<QuerySnapshot<UserProfile>> getUserProfiles() {
    return _usersCollection
        ?.where("uid", isNotEqualTo: authService.user!.uid)
        .snapshots() as Stream<QuerySnapshot<UserProfile>>;
  }

  Future<bool> checkIfChatExits(String uuid1, String uuid2) async {
    String chatId = generateChatId(uuid1: uuid1, uuid2: uuid2);
    final result = await _chatCollection?.doc(chatId).get();
    if (result != null) {
      return result.exists;
    } else {
      return false;
    }
  }

  Future<void> createNewChat(String uuid1, String uuid2) async {
    String chatId = generateChatId(uuid1: uuid1, uuid2: uuid2);

    final docRef = _chatCollection!.doc(chatId);
    final chat = Chat(id: chatId, participantIds: [uuid1, uuid2], messages: []);
    await docRef.set(chat);
  }
}
