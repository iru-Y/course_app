import 'dart:convert';

import 'package:course_app/api_path.dart';
import 'package:course_app/user/register_model.dart';
import 'package:http/http.dart' as http;

Future<void> registerRepo(
  String? name,
  String? email,
  String? cpf,
  String? password,
  String? passwordCheck,
) async {
  final url = Uri.parse('$apiPath/v1/user');
  final data = RegisterModel();

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
