import 'package:http/http.dart' as http;

abstract class HttpClient {
  Future<http.Response> post(String url, Map<String, dynamic> body);
  Future<http.Response> patch(String url, Map<String, dynamic> body);
  Future<http.Response> get(String url);
  Future<http.Response> delete(String url);
}
