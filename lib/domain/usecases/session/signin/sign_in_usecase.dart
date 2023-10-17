import 'package:book/data/models/Result.dart';
import 'package:book/data/models/user_model.dart';
import 'package:book/domain/repositories/user_repository.dart';

class SignInUseCase {
  final UserRepository userRepository;

  SignInUseCase({required this.userRepository});

  Future<UserModel?> signInWithGoogle() async {
    Result<UserModel> response = await userRepository.signInWithGoogle();
    print(response);
    if (response.isSuccess) {
      return response.value;
    } else {
      return null;
    }
  }

  Future<UserModel?> signInWithApple() async {
    Result<UserModel> response = await userRepository.signInWithApple();
    if (response.isSuccess) {
      return response.value;
    } else {
      return null;
    }
  }

  Future<UserModel?> autoLogin() async {
    Result<UserModel> response = await userRepository.autoLogin();
    if (response.isSuccess) {
      return response.value;
    } else {
      print(response.error.toString());
      return null;
    }
  }

  Future<bool> deleteUserAccount() async {
    var response = await userRepository.deleteAccount();
    return response.isSuccess;
  }
}
