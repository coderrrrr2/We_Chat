import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/core/services/image_picker_service.dart';
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
  // ignore: unused_field
  File? _selectedImage;

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
          stream: chatService.getMessages(currentUser!.id, otherUser!.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive();
            }
            if (snapshot.hasData) {
              Chat? chat = snapshot.data.data();
              List<ChatMessage> messages = [];
              if (chat != null && chat.messages != null) {
                messages = generateChatMessageList(chat.messages!);
                messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
              }

              return DashChat(
                  messageOptions: const MessageOptions(showTime: true),
                  inputOptions: InputOptions(
                      alwaysShowSend: true, trailing: [mediaPageButton()]),
                  currentUser: currentUser!,
                  onSend: (message) {
                    sendMessage(message);
                  },
                  messages: messages);
            }
            return Container();
          }),
    );
  }

  Future<void> sendMessage(ChatMessage messageTyped) async {
    if (messageTyped.medias?.isNotEmpty ?? false) {
      if (messageTyped.medias!.first.type == MediaType.image) {
        Message message = Message(
            senderId: currentUser!.id,
            content: messageTyped.medias!.first.url,
            sentAt: Timestamp.fromDate(messageTyped.createdAt),
            messageType: MessageType.image);
        await chatService.sendChatMessage(
            currentUser!.id, otherUser!.id, message);
        return;
      }
    }
    Message message = Message(
        senderId: currentUser!.id,
        content: messageTyped.text,
        sentAt: Timestamp.fromDate(messageTyped.createdAt),
        messageType: MessageType.text);
    await chatService.sendChatMessage(currentUser!.id, otherUser!.id, message);
  }

  List<ChatMessage> generateChatMessageList(List<Message> messages) {
    return messages.map((message) {
      if (message.messageType == MessageType.image) {
        return ChatMessage(
            medias: [
              ChatMedia(
                  url: message.content!, type: MediaType.image, fileName: '')
            ],
            user:
                message.senderId == currentUser!.id ? currentUser! : otherUser!,
            createdAt: message.sentAt!.toDate());
      }
      return ChatMessage(
          medias: message.messageType == MessageType.image
              ? [
                  ChatMedia(
                      url: message.content!,
                      type: MediaType.image,
                      fileName: '')
                ]
              : [],
          text: message.content!,
          user: message.senderId == currentUser!.id ? currentUser! : otherUser!,
          createdAt: message.sentAt!.toDate());
    }).toList();
  }

  Widget mediaPageButton() {
    return IconButton(
      icon: const Icon(Icons.photo),
      onPressed: () async {
        final image = await ImagePickerService.pickImageFromGallery();
        if (image != null) {
          setState(() {
            _selectedImage = image;
          });
        }
        String chatId =
            generateChatId(uuid1: currentUser!.id, uuid2: otherUser!.id);

        storageService
            .uploadChatImage(file: _selectedImage!, chatId: chatId)
            .then((url) {
          if (url != null) {
            ChatMessage message = ChatMessage(
              user: currentUser!,
              createdAt: DateTime.now(),
              medias: [
                ChatMedia(url: url, type: MediaType.image, fileName: '')
              ],
            );
            sendMessage(message);
          }
        });
      },
    );
  }
}
