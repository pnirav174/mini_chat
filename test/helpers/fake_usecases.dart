import 'package:mini_chat/domain/entities/message.dart';
import 'package:mini_chat/domain/entities/user.dart';
import 'package:mini_chat/domain/usecases/fetch_random_message.dart';
import 'package:mini_chat/domain/usecases/get_users.dart';
import 'package:mini_chat/domain/usecases/fetch_word_meaning.dart';

import '../domain/usecases/fetch_word_meaning_test.dart';

// A single fake repository instance
final _fakeRepo = FakeChatRepository();

// Fake for FetchRandomMessage
class FakeFetchRandomMessage extends FetchRandomMessage {
  FakeFetchRandomMessage() : super(_fakeRepo);

  @override
  Future<Message> call() async {
    return Message(
      id: '1',
      senderId: '1',
      content: 'Hello',
      isSender: false,
      timestamp: DateTime.now(),
    );
  }
}

// Fake for GetUsers
class FakeGetUsers extends GetUsers {
  FakeGetUsers() : super(_fakeRepo);

  @override
  Future<List<User>> call() async {
    return [User(id: '1', name: 'John')];
  }
}

// Fake for FetchWordMeaning
class FakeFetchWordMeaning extends FetchWordMeaning {
  FakeFetchWordMeaning() : super(_fakeRepo);

  @override
  Future<String> call(String word) async {
    return 'A greeting';
  }
}
