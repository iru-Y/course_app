import 'dart:convert';

import 'package:course_app/api_path.dart';
import 'package:course_app/user/register_model.dart';
import 'package:http/http.dart' as http;

Future<void> registerRepo(
  String name,
  String email,
  String cpf,
  String password,
  String passwordCheck,
) async {
  if (password != passwordCheck) {
    throw Exception('As senhas não coincidem');
  }

  final url = Uri.parse('$apiPath/v1/user');
  final data = RegisterModel(
    name: name,
    email: email,
    cpf: cpf,
    password: password,
    passwordCheck:  passwordCheck
  );

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(_parseError(response.body));
    }
  } catch (e) {
    throw Exception('Falha no registro: ${e.toString().replaceAll('Exception: ', '')}');
  }
}

String _parseError(String body) {
  try {
    final json = jsonDecode(body);
    return json['message'] ?? 'Erro desconhecido';
  } catch (_) {
    return 'Erro no servidor';
  }
}