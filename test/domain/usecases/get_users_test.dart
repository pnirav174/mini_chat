import 'package:flutter_test/flutter_test.dart';
import 'package:mini_chat/domain/usecases/get_users.dart';

import 'fetch_word_meaning_test.dart';

void main() {
  late GetUsers usecase;

  setUp(() {
    usecase = GetUsers(FakeChatRepository());
  });

  test('returns list of users', () async {
    final users = await usecase();

    expect(users.length, 1);
    expect(users.first.name, 'John');
  });
}
