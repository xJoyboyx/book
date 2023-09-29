import 'package:book/data/models/Result.dart';
import 'package:book/data/models/user_model.dart';
import 'package:book/data/services/user_service.dart';
import 'package:book/domain/entities/user_credential.dart';
import 'package:book/domain/repositories/user_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart' as apple_sign_in;

class UserRepositoryImpl implements UserRepository {
  final SharedPreferences sharedPreferences;
  final GoogleSignIn googleSignIn;
  final UserService userService;

  UserRepositoryImpl(
      {required this.sharedPreferences,
      required this.googleSignIn,
      required this.userService});

  @override
  Future<Result<UserModel>> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      await googleSignInAccount.authentication;

      final String userId = googleSignInAccount.id;
      final String userEmail = googleSignInAccount.email;
      final UserCredential userCredential = UserCredential(
          external_user_id: userId, email: userEmail, type: 'google_login');

      Result<UserModel> result = await userService.registerUser(userCredential);
      return result;
    }
    return Result.failure('GOOGLE_SIGN_IN_ERROR');
  }

  @override
  Future<Result<UserModel>> signInWithApple() async {
    String type = 'apple_login';
    try {
      final credential =
          await apple_sign_in.SignInWithApple.getAppleIDCredential(
        scopes: [
          apple_sign_in.AppleIDAuthorizationScopes.email,
        ],
      );

      final String userId = credential.userIdentifier!;
      final UserCredential userCredential = UserCredential(
          external_user_id: userId, email: credential.email, type: type);

      if (credential.email != null) {
        Result<UserModel> result =
            await userService.registerUser(userCredential);
        return result;
      }

      return Result.failure('APPLE_SIGN_IN_ERROR');
    } catch (error) {
      return Result.failure('APPLE_SIGN_IN_ERROR: ${error}');
    }
  }

  @override
  Future<Result<UserModel>> autoLogin() async {
    try {
      final userId = sharedPreferences.getString('userId');
      if (userId != null) {
        Result<UserModel> response = await userService.getUser(userId);
        return response;
      }
    } catch (e) {
      return Result.failure('AUTO_SIGN_ERROR: ${e}');
    }
    return Result.failure('AUTO_SIGN_ERROR');
  }
}
