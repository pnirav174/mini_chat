import 'package:flutter_test/flutter_test.dart';
import 'package:mini_chat/domain/usecases/fetch_random_message.dart';

import 'fetch_word_meaning_test.dart';

void main() {
  late FetchRandomMessage usecase;

  setUp(() {
    usecase = FetchRandomMessage(FakeChatRepository());
  });

  test('returns a random message', () async {
    final result = await usecase();

    expect(result.content, 'Hello');
    expect(result.isSender, false);
  });
}
