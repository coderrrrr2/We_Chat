import 'package:flutter/material.dart';
import 'package:practice_chat_app/models/user_model.dart';

class ChatTile extends StatelessWidget {
  final UserProfile userProfile;
  final VoidCallback ontap;
  const ChatTile({super.key, required this.userProfile, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: ontap,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(userProfile.pfpUrl),
        ),
        title: Text(userProfile.name),
      ),
    );
  }
}
