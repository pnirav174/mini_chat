import 'package:mini_chat/domain/repositories/chat_repository.dart';

class FetchWordMeaning {
  final ChatRepository repository;

  FetchWordMeaning(this.repository);

  Future<String> call(String word) async {
    return await repository.fetchWordMeaning(word);
  }
}
