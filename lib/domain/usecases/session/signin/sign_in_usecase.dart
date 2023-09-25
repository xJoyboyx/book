import 'package:book/domain/entities/user_credential.dart';
import 'package:book/domain/repositories/user_repository.dart';

class SignInUseCase {
  final UserRepository userRepository;

  SignInUseCase({required this.userRepository});

  Future<UserCredential> signInWithGoogle() {
    return userRepository.signInWithGoogle();
  }

  Future<UserCredential> signInWithApple() {
    return userRepository.signInWithApple();
  }

  Future<bool> autoLogin() {
    return userRepository.autoLogin();
  }
}
