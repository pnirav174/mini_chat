import 'package:mini_chat/domain/entities/message.dart';
import 'package:mini_chat/domain/entities/user.dart';
import 'package:mini_chat/domain/repositories/chat_repository.dart';

class FakeChatRepository implements ChatRepository {
  @override
  Future<Message> fetchRandomMessage() async {
    return Message(
      id: "1",
      senderId: "1",
      content: "Hello",
      isSender: false,
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<List<User>> getUsers() async => [User(id: "1", name: "John")];

  @override
  Future<String> fetchWordMeaning(String word) async {
    return 'A greeting';
  }

  @override
  Future<void> addUser(user) async {}
}
