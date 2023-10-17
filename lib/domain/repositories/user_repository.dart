import 'package:book/data/models/Result.dart';
import 'package:book/data/models/user_model.dart';

abstract class UserRepository {
  Future<Result<UserModel>> signInWithGoogle();
  Future<Result<UserModel>> signInWithApple();
  Future<Result<UserModel>> autoLogin();
  Future<Result> deleteAccount();
}
