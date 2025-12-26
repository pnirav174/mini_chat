import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mini_chat/data/models/user_model.dart';
import 'package:mini_chat/domain/entities/message.dart';
import 'package:mini_chat/domain/usecases/fetch_random_message.dart';
import 'package:mini_chat/domain/usecases/fetch_word_meaning.dart';
import 'package:mini_chat/domain/usecases/get_users.dart';
import 'package:mini_chat/models/chat_session.dart';

class ChatProvider extends ChangeNotifier {
  late FetchRandomMessage _fetchRandomMessage;
  late GetUsers _getUsers;
  late FetchWordMeaning _fetchWordMeaning;

  // Users List
  List<UserModel> users = [];

  // Chat History
  List<ChatSessionModel> chatSessions = [];

  // Chat Messages
  Map<String, List<Message>> messages = {};

  UserModel currentUser = UserModel(id: 'me', name: 'Me');

  ChatProvider({
    required FetchRandomMessage fetchRandomMessage,
    required GetUsers getUsers,
    required FetchWordMeaning fetchWordMeaning,
  }) {
    _fetchRandomMessage = fetchRandomMessage;
    _getUsers = getUsers;
    _fetchWordMeaning = fetchWordMeaning;
    _initializeUsers();
  }
  Future<void> _initializeUsers() async {
    final fetchedUsers = await _getUsers.call();
    users.addAll(
      fetchedUsers.map(
        (u) => UserModel(
          id: u.id,
          name: u.name,
          isOnline: u.isOnline,
          lastActive: u.lastActive,
        ),
      ),
    );
    notifyListeners();
  }

  void addUser(String name) {
    final newUser = UserModel(
      id: DateTime.now().toString(),
      name: name,
      isOnline: Random().nextBool(),
      lastActive: "Just now",
    );
    users.insert(0, newUser);
    notifyListeners();
  }

  List<Message> getMessages(String userId) {
    return messages[userId] ?? [];
  }

  Future<void> fetchAndAddMessage(String userId) async {
    final message = await _fetchRandomMessage.call();
    _addMessageToStore(userId, message);
    _updateChatSession(userId, message);
    notifyListeners();
  }

  // Send message
  void sendMessage(String userId, String content) {
    final message = Message(
      id: DateTime.now().toString(),
      content: content,
      timestamp: DateTime.now(),
      isSender: true,
      senderId: currentUser.id,
    );

    _addMessageToStore(userId, message);
    _updateChatSession(userId, message);

    _fetchReply(userId);
  }

  Future<void> _fetchReply(String userId) async {
    await Future.delayed(const Duration(seconds: 1));

    final message = await _fetchRandomMessage.call();

    _addMessageToStore(userId, message);
    _updateChatSession(userId, message);
  }

  void _addMessageToStore(String userId, Message message) {
    if (!messages.containsKey(userId)) {
      messages[userId] = [];
    }
    messages[userId]!.add(message);
    notifyListeners();
  }

  void _updateChatSession(String userId, Message lastMessage) {
    final userIndex = users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return;

    final user = users[userIndex];
    final sessionIndex = chatSessions.indexWhere((s) => s.user.id == userId);

    final newSession = ChatSessionModel(
      sessionId: userId,
      user: user,
      lastMessage: lastMessage.content,
      lastActive: lastMessage.timestamp,
      unreadCount: lastMessage.isSender ? 0 : 1,
    );

    if (sessionIndex != -1) {
      chatSessions.removeAt(sessionIndex);
    }
    chatSessions.insert(0, newSession);
    notifyListeners();
  }

  Future<String> fetchWordMeaning(String word) async {
    return await _fetchWordMeaning.call(word);
  }
}
