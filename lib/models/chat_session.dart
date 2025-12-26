import 'package:mini_chat/data/models/user_model.dart';

class ChatSessionModel {
  final String sessionId;
  final UserModel user;
  final String lastMessage;
  final DateTime lastActive;
  final int unreadCount;

  ChatSessionModel({
    required this.sessionId,
    required this.user,
    required this.lastMessage,
    required this.lastActive,
    this.unreadCount = 0,
  });
}
