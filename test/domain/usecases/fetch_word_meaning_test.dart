import 'package:flutter_test/flutter_test.dart';
import 'package:mini_chat/domain/usecases/fetch_word_meaning.dart';
import '../../helpers/fake_chat_repository.dart';

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
