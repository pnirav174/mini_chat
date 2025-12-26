import 'package:mini_chat/domain/entities/message.dart';
import 'package:mini_chat/domain/entities/user.dart';

abstract class ChatRepository {
  Future<List<User>> getUsers();
  Future<void> addUser(User user);
  Future<Message> fetchRandomMessage();
  Future<String> fetchWordMeaning(String word);
}
