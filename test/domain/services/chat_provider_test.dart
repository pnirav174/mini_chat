import 'package:flutter_test/flutter_test.dart';
import 'package:mini_chat/domain/entities/message.dart';
import 'package:mini_chat/domain/entities/user.dart';
import 'package:mini_chat/services/chat_provider.dart';
import 'package:mini_chat/domain/usecases/fetch_random_message.dart';
import 'package:mini_chat/domain/usecases/get_users.dart';
import 'package:mini_chat/domain/usecases/fetch_word_meaning.dart';

import '../../helpers/fake_chat_repository.dart';

class FakeFetchRandomMessage extends FetchRandomMessage {
  FakeFetchRandomMessage() : super(FakeChatRepository());

  @override
  Future<Message> call() async {
    return Message(
      id: "1",
      senderId: "2",
      content: "Hello",
      isSender: false,
      timestamp: DateTime.now(),
    );
  }
}

class FakeGetUsers extends GetUsers {
  FakeGetUsers() : super(FakeChatRepository());

  @override
  Future<List<User>> call() async => [User(id: "1", name: "John")];
}

class FakeFetchWordMeaning extends FetchWordMeaning {
  FakeFetchWordMeaning() : super(FakeChatRepository());

  @override
  Future<String> call(String word) async => 'Meaning';
}

void main() {
  late ChatProvider provider;

  setUp(() {
    provider = ChatProvider(
      fetchRandomMessage: FakeFetchRandomMessage(),
      getUsers: FakeGetUsers(),
      fetchWordMeaning: FakeFetchWordMeaning(),
    );
  });

  test('adds message when fetched', () async {
    await provider.fetchAndAddMessage("1");

    final messages = provider.getMessages("1");

    // Debug prints
    print('Messages count: ${messages.length}');
    print('First message content: ${messages.first.content}');

    expect(messages.length, 1);
    expect(messages.first.content, 'Hello');
  });
}
