import 'dart:convert';

import 'package:book/data/datasources/endpoints.dart';
import 'package:book/data/models/Result.dart';
import 'package:book/data/models/http_client.dart';
import 'package:book/data/models/user_model.dart';
import 'package:book/domain/entities/user_credential.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final HttpClient httpClient;
  final SharedPreferences sharedPreferences;
  UserService({required this.httpClient, required this.sharedPreferences});

  Future<void> registerUser(UserCredential userCredential) async {
    final body = {
      'external_id': userCredential.external_user_id.toString(),
      if (userCredential.email != null) 'email': userCredential.email,
      'service_type': userCredential.type,
    };
    final response = await httpClient.post('${URL}/users/register', body);
    print(response);
    try {
      final user = UserModel.fromJson(jsonDecode(response.body));
      sharedPreferences.setString('userId', user.id);
    } catch (e) {
      print('La respuesta no es un Map<String, dynamic> ${e}');
    }
  }

  Future<Result<UserModel>> getUser(String userId) async {
    try {
      final response = await httpClient.get('${URL}/users/$userId');
      final UserModel user = UserModel.fromJson(jsonDecode(response.body));
      sharedPreferences.setString('userId', user.id);
      print('Usuario ingresado con email: ${user.email}');
      return Result.success(user);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
