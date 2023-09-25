import 'package:book/data/models/http_client.dart';
import 'package:book/domain/entities/user_credential.dart';

class UserService {
  final HttpClient httpClient;

  UserService({required this.httpClient});

  Future<void> registerUser(UserCredential userCredential) async {
    final body = {
      'external_id': userCredential.external_user_id,
      if (userCredential.email != null) 'email': userCredential.email,
      'service_type': userCredential.email != null
          ? 'apple_login'
          : 'google_login', // Ajusta esto según tus necesidades
    };

    await httpClient.post('https://your-api.com/user/register', body);
  }

  Future<void> getUser(String userId) async {
    await httpClient.get('https://your-api.com/users/$userId');
  }
}
