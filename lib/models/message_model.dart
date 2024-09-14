import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice_chat_app/features/home/data/enums.dart';

class Message {
  final String? senderId;
  final String? content;
  final Timestamp? sentAt;
  final MessageType? messageType;

  Message({
    required this.senderId,
    required this.content,
    required this.sentAt,
    required this.messageType,
  });

  // Convert Message to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'content': content,
      'messageType':
          messageType.toString().split('.').last, // Store enum as a string
      'sentAt': sentAt
    };
  }

  // Create Message from Firebase JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      content: json['content'],
      sentAt: json['sentAt'],
      messageType: MessageType.values.firstWhere(
          (e) => e.toString() == 'MessageType.' + json['messageType']),
    );
  }
}
