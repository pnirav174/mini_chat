import 'package:mini_chat/domain/entities/user.dart';

class ChatSession {
  final String sessionId;
  final User user;
  final String lastMessage;
  final DateTime lastActive;
  final int unreadCount;

  ChatSession({
    required this.sessionId,
    required this.user,
    required this.lastMessage,
    required this.lastActive,
    this.unreadCount = 0,
  });
}
