import 'package:mini_chat/domain/entities/user.dart';
import 'package:mini_chat/domain/repositories/chat_repository.dart';

class GetUsers {
  final ChatRepository repository;

  GetUsers(this.repository);

  Future<List<User>> call() async {
    return await repository.getUsers();
  }
}
