import 'dart:convert';
import 'package:book/data/models/http_client.dart';
import 'package:http/http.dart' as http;

class HttpClientImpl implements HttpClient {
  @override
  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  @override
  Future<Map<String, dynamic>> get(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get data');
    }
  }
}
