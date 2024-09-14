import 'package:practice_chat_app/features/home/data/enums.dart';

class Message {
  final String? id;
  final String? senderId;
  final String? content;
  final DateTime? timestamp;
  final MessageType? messageType;

  Message({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.messageType,
  });

  // Convert Message to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'content': content,
      'messageType':
          messageType.toString().split('.').last, // Store enum as a string
    };
  }

  // Create Message from Firebase JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      messageType: MessageType.values.firstWhere(
          (e) => e.toString() == 'MessageType.' + json['messageType']),
    );
  }
}
