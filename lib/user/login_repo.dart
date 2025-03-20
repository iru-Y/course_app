import 'dart:convert';
import 'package:course_app/api_path.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  Future<void> login(String email, String password) async {
  final url = Uri.parse('$apiPath/v1/auth/login');
  final data = {'email': email, 'password': password};

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Sucesso: ${response.body}");
    } else {
      throw Exception("Erro: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    throw Exception("Erro na requisição: $e");
  }
}
}
