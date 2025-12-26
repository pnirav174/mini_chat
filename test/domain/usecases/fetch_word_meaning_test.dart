import 'package:flutter_test/flutter_test.dart';
import 'package:mini_chat/domain/entities/message.dart';
import 'package:mini_chat/domain/entities/user.dart';
import 'package:mini_chat/domain/usecases/fetch_word_meaning.dart';
import 'package:mini_chat/domain/repositories/chat_repository.dart';

class FakeChatRepository extends ChatRepository {
  @override
  Future<String> fetchWordMeaning(String word) async {
    return 'A greeting';
  }

  @override
  Future<List<User>> getUsers() async => [User(id: "1", name: "John")];

  @override
  Future<void> addUser(user) async {}

  @override
  Future<Message> fetchRandomMessage() async {
    return Message(
      id: "1",
      senderId: "2",
      content: "Hello",
      isSender: false,
      timestamp: DateTime.now(),
    );
  }
}

void main() {
  late FetchWordMeaning usecase;

  setUp(() {
    usecase = FetchWordMeaning(FakeChatRepository());
  });

  test('returns meaning of a word', () async {
    final result = await usecase('hello');

    expect(result, 'A greeting');
  });
}
