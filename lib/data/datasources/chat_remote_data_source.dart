import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:mini_chat/data/models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<MessageModel> fetchRandomMessage();
  Future<String> fetchWordMeaning(String word);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final http.Client client;

  ChatRemoteDataSourceImpl({required this.client});

  @override
  Future<MessageModel> fetchRandomMessage() async {
    try {
      final randomLimit = Random().nextInt(340);

      final response = await client.get(
        Uri.parse('https://dummyjson.com/comments?limit=$randomLimit'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['comments'] != null && data['comments'].isNotEmpty) {
          final comments = data['comments'] as List;
          final randomIndex = Random().nextInt(comments.length);
          return MessageModel.fromJson(comments[randomIndex]);
        }
      }
      return MessageModel(
        id: DateTime.now().toString(),
        content: "Hello! This is a fallback message.",
        timestamp: DateTime.now(),
        isSender: false,
        senderId: 'api',
      );
    } catch (e) {
      // Return fallback
      return MessageModel(
        id: DateTime.now().toString(),
        content: "Sorry, I couldn't reach the server.",
        timestamp: DateTime.now(),
        isSender: false,
        senderId: 'api',
      );
    }
  }

  @override
  Future<String> fetchWordMeaning(String word) async {
    try {
      final response = await client.get(
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List && data.isNotEmpty) {
          final meanings = data[0]['meanings'] as List;
          if (meanings.isNotEmpty) {
            final definitions = meanings[0]['definitions'] as List;
            if (definitions.isNotEmpty) {
              return definitions[0]['definition'] ?? 'Definition not found.';
            }
          }
        }
      }
      return 'Definition not found.';
    } catch (e) {
      return 'Error fetching definition.';
    }
  }
}
