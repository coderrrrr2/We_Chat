import 'package:flutter/material.dart';
import 'package:practice_chat_app/models/user_model.dart';

class ChatTile extends StatelessWidget {
  final UserProfile userProfile;
  const ChatTile({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userProfile.pfpUrl),
      ),
    );
  }
}
