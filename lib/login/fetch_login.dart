import 'dart:convert';

import 'package:course_app/api_path.dart';
import 'package:http/http.dart' as http;

login(String email, String password) async {
  final url = Uri.parse('${apiPath}/v1/user');
  final data = login(email, password);
  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Sucesso: ${response.body}");
    } else {
      print("Erro: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("Erro na requisição: $e");
  }
}
