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
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final String userId = googleSignInAccount.id;
        final String userEmail = googleSignInAccount.email;
        print('💼userId: ${userId}');
        sharedPreferences.setString('userId', userId);
        final UserCredential userCredential =
            UserCredential(external_user_id: userId, email: userEmail);
        await userService.registerUser(userCredential);

        return userCredential;
      }

      return UserCredential(external_user_id: '');
    } catch (error) {
      print(error);
      return UserCredential(external_user_id: '');
    }
  }

  @override
  Future<UserCredential> signInWithApple() async {
    try {
      final credential =
          await apple_sign_in.SignInWithApple.getAppleIDCredential(
        scopes: [
          apple_sign_in.AppleIDAuthorizationScopes.email,
        ],
      );

      final String userId = credential.userIdentifier!;
      sharedPreferences.setString('user_id', userId);
      final UserCredential userCredential =
          UserCredential(external_user_id: userId, email: credential.email);

      if (credential.email != null) {
        await userService.registerUser(userCredential);
      }

      return userCredential;
    } catch (error) {
      print(error);
      return UserCredential(external_user_id: '');
    }
  }

  @override
  Future<bool> autoLogin() {
    final userId = sharedPreferences.getString('user_id');
    return Future.value(userId != null);
  }
}
