import 'package:mini_chat/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.id,
    required super.content,
    required super.timestamp,
    required super.isSender,
    required super.senderId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: DateTime.now().toString(),
      content: json['body'] ?? '',
      timestamp: DateTime.now(),
      isSender: false,
      senderId: 'api',
    );
  }
}
