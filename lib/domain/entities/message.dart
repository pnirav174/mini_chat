class Message {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isSender;
  final String senderId;

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.isSender,
    required this.senderId,
  });
}
