import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errors/exceptions.dart';
import 'endpoints.dart';

class ApiClient {
  final http.Client client;

  ApiClient(this.client);

  Future<dynamic> get(String url) async {
    final response = await client.get(Uri.parse("${Endpoints.baseUrl}$url"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode >= 500) {
      throw ServerException("Server Error (${response.statusCode})");
    } else {
      throw UnexpectedException("Unexpected Error (${response.statusCode})");
    }
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    final response = await client.post(
      Uri.parse("${Endpoints.baseUrl}$url"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else if (response.statusCode >= 500) {
      throw ServerException("Server Error (${response.statusCode})");
    } else {
      throw UnexpectedException("Unexpected Error (${response.statusCode})");
    }
  }
}
