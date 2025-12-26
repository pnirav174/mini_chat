import 'package:mini_chat/domain/entities/message.dart';
import 'package:mini_chat/domain/repositories/chat_repository.dart';

class FetchRandomMessage {
  final ChatRepository repository;

  FetchRandomMessage(this.repository);

  Future<Message> call() async {
    return await repository.fetchRandomMessage();
  }
}
