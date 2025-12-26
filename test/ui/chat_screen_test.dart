import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_chat/screens/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:mini_chat/services/chat_provider.dart';

import '../domain/services/chat_provider_test.dart';

void main() {
  late ChatProvider provider;

  setUp(() {
    provider = ChatProvider(
      fetchRandomMessage: FakeFetchRandomMessage(),
      getUsers: FakeGetUsers(),
      fetchWordMeaning: FakeFetchWordMeaning(),
    );
  });

  testWidgets('sending message shows it in chat UI', (
    WidgetTester tester,
  ) async {
    print('=== Starting test ===');

    // Wrap ChatScreen with the **same provider instance**
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(
          home: ChatScreen(userId: "1", userName: "John"),
        ),
      ),
    );

    print('Widget tree pumped');

    // Let any initial async operations finish
    await tester.pumpAndSettle();

    print('Initial pumpAndSettle done');
    print('Messages before adding: ${provider.getMessages('1').length}');

    // Add a message using the same provider instance
    await provider.fetchAndAddMessage('1');

    print('fetchAndAddMessage called');
    print('Messages after adding: ${provider.getMessages('1').length}');
    if (provider.getMessages('1').isNotEmpty) {
      print(
        'First message content: ${provider.getMessages('1').first.content}',
      );
    }

    // Rebuild UI after adding message
    await tester.pumpAndSettle();

    print('After pumpAndSettle, checking UI');

    // Verify the message appears in the UI
    expect(find.text('Hello '), findsOneWidget);

    print('Test finished successfully');
  });
}
