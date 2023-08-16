import 'package:my_budget/user/domain/models/user_model.dart';

abstract class UserRepository {
  //Getters
  String? get userId;
  User? get currentUser;

  Future<User?> getUser(String id);
  Future<void> createUser(User user);
}
