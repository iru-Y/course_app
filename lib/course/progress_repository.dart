// progress_repo.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:course_app/api_path.dart';
import 'package:course_app/course/progress_model.dart';

class ProgressRepo {
  Future<ProgressResponse> getInfoByProgress(
    String userId,
    String courseId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$apiPath/v1/progress/67cb65596e3e9b7fb2317ce5/67c760e629e61e905add3197',
        ),
      );

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

Future<ProgressResponse> getProgressPercentage(
  String userId,
  String courseId,
) async {
  try {
    final response = await http.get(
      Uri.parse(
        '$apiPath/v1/course-progress/67cb65596e3e9b7fb2317ce5/67c760e629e61e905add3197',
      ),
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
}}
