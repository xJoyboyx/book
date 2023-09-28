import 'dart:convert';
import 'dart:io';
import 'package:book/data/models/http_client.dart';
import 'package:http/http.dart' as http;

class HttpClientImpl implements HttpClient {
  @override
  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data: ${response.body}');
    }
  }

  @override
  Future<http.Response> get(String url) async {
    final response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to get data');
    }
  }
}
