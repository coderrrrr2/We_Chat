import 'package:practice_chat_app/models/message_model.dart';

class Chat {
  final String? id;
  final List<String>? participantIds;
  final List<Message>? messages;

  Chat({
    required this.id,
    required this.participantIds,
    required this.messages,
  });

  // Convert Chat to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participantIds': participantIds,
      'messages': messages?.map((message) => message.toJson()).toList(),
    };
  }

  // Create Chat from Firebase JSON
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      participantIds: List<String>.from(json['participantIds']),
      messages: (json['messages'] as List)
          .map((message) => Message.fromJson(message))
          .toList(),
    );
  }
}
