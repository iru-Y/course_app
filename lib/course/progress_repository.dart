// progress_repo.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:course_app/api_path.dart';
import 'package:course_app/course/progress_model.dart';

class ProgressRepo {
  Future<ProgressResponse> getProgress(String userId, courseId) async {
    try {
      final response = await http.get(
        Uri.parse("$apiPath/v1/progress/$userId/$courseId"),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ProgressResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Falha ao carregar progresso: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro em getProgress: $e');
      rethrow;
    }
  }
}