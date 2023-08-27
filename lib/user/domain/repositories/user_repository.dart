import 'package:my_budget/user/domain/models/user_model.dart';

abstract class UserRepository {
  //Getters
  String? get userId;
  UserModel? get currentUser;

  Future<UserModel?> getUser(String id);
  Future<void> createUser(UserModel user);
}
