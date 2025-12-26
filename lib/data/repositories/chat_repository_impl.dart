import 'package:mini_chat/data/datasources/chat_remote_data_source.dart';
import 'package:mini_chat/domain/entities/message.dart';
import 'package:mini_chat/domain/entities/user.dart';
import 'package:mini_chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  final List<User> _users = [];

  ChatRepositoryImpl({required this.remoteDataSource}) {
    _initializeUsers();
  }

  void _initializeUsers() {
    _users.addAll([
      User(id: '1', name: 'Alice Johnson', isOnline: true),
      User(
        id: '2',
        name: 'Bob Smith',
        isOnline: false,
        lastActive: '2 min ago',
      ),
      User(id: '3', name: 'Carol Williams', isOnline: true),
      User(
        id: '4',
        name: 'David Brown',
        isOnline: false,
        lastActive: '1 hour ago',
      ),
      User(id: '5', name: 'Emma Davis', isOnline: true),
      User(
        id: '6',
        name: 'Frank Miller',
        isOnline: false,
        lastActive: '5 min ago',
      ),
      User(id: '7', name: 'Grace Wilson', isOnline: true),
      User(
        id: '8',
        name: 'Henry Moore',
        isOnline: false,
        lastActive: '2 days ago',
      ),
    ]);
  }

  @override
  Future<List<User>> getUsers() async {
    return _users;
  }

  @override
  Future<void> addUser(User user) async {
    _users.insert(0, user);
  }

  @override
  Future<Message> fetchRandomMessage() async {
    return await remoteDataSource.fetchRandomMessage();
  }

  @override
  Future<String> fetchWordMeaning(String word) async {
    return await remoteDataSource.fetchWordMeaning(word);
  }
}
