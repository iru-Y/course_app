// progress_repo.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:course_app/api_path.dart';
import 'package:course_app/course/progress_model.dart';

class ProgressRepo {
  // No ProgressRepo
Future<ProgressResponse> getProgress(String userId, String courseId) async {
  try {
    final response = await http.get(
      Uri.parse('$apiPath/v1/progress/67cb61fe6e3e9b7fb2317ce1/67c760e629e61e905add3197'),
    );

    print('Resposta do Progresso: ${response.body}');

    if (response.statusCode == 200) {
      return ProgressResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar progresso');
    }
  } catch (e) {
    print('Erro em getProgress: $e');
    rethrow;
  }
}
}