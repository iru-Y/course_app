import 'dart:convert';
import 'package:course_app/api_path.dart';
import 'package:course_app/user/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  Future<UserModel> getUser(String email) async {
    try {
      final response = await http.get(Uri.parse("$apiPath/v1/user/$email"));

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // A resposta direta do endpoint /user/{email} é o objeto do usuário
        return UserModel.fromJson(jsonResponse);
      } else {
        throw Exception('Falha ao carregar usuário: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro em getUser: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final response = await http.get(Uri.parse("$apiPath/v1/user/$email"));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      var resp = UserModel.fromJson(jsonResponse);
      print('resposta do getuserbyemail: $resp');
      return resp;
    } else {
      throw Exception(
        'Falha ao carregar cursos por email : ${response.statusCode}',
      );
    }
  }
}
