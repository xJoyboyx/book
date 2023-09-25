import 'package:book/domain/entities/user_credential.dart';

abstract class UserRepository {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInWithApple();
  Future<bool> autoLogin();
}
