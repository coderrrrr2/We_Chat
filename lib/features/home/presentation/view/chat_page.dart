import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/features/auth/viewmodel/provider_list.dart';
import 'package:practice_chat_app/features/home/data/enums.dart';
import 'package:practice_chat_app/models/chat_model.dart';
import 'package:practice_chat_app/models/message_model.dart';
import 'package:practice_chat_app/models/user_model.dart';

class ChatPageArgs {
  final UserProfile userProfile;
  ChatPageArgs({required this.userProfile});
}

class ChatPage extends StatefulWidget {
  final ChatPageArgs args;
  const ChatPage({super.key, required this.args});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatUser? currentUser, otherUser;

  @override
  void initState() {
    super.initState();
    currentUser = ChatUser(
        id: authService.user!.uid, firstName: authService.user!.displayName);
    otherUser = ChatUser(
        id: widget.args.userProfile.uid,
        firstName: widget.args.userProfile.name,
        profileImage: widget.args.userProfile.pfpUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.args.userProfile.name),
      ),
      body: StreamBuilder(
          stream: dataBaseService.getMessages(currentUser!.id, otherUser!.id),
          builder: (context, snapshot) {
            Chat? chat = snapshot.data.data();
            final List<ChatMessage> messages = [];
            return DashChat(
                messageOptions:
                    MessageOptions(showCurrentUserAvatar: true, showTime: true),
                inputOptions: InputOptions(alwaysShowSend: true),
                currentUser: currentUser!,
                onSend: (message) {
                  sendMessage(message);
                },
                messages: messages);
          }),
    );
  }

  Future<void> sendMessage(ChatMessage messageTyped) async {
    Message message = Message(
        senderId: currentUser!.id,
        content: messageTyped.text,
        sentAt: Timestamp.fromDate(messageTyped.createdAt),
        messageType: MessageType.text);
    await dataBaseService.sendChatMessage(
        currentUser!.id, otherUser!.id, message);
  }
}
