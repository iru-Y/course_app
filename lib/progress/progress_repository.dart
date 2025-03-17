import 'dart:convert';
import 'package:course_app/api_path.dart';
import 'package:http/http.dart' as http;
import 'progress_model.dart';

class ProgressRepository {
  Future<Progress?> getProgress(String userId, String courseId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$apiPath/v1/progress/67cb61fe6e3e9b7fb2317ce1/67c760e629e61e905add3197',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Progress.fromJson(json['progress']);
      } else {
        print('Erro ao buscar progresso: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao buscar progresso: $e');
      return null;
    }
  }

  Future<bool> updateProgress(Progress progress) async {
    try {
      final response = await http.put(
        Uri.parse('$apiPath/v1/progress/${progress.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(progress.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Erro ao atualizar progresso: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erro ao atualizar progresso: $e');
      return false;
    }
  }

  Future<bool> createProgress(Progress progress) async {
    try {
      final response = await http.post(
        Uri.parse('$apiPath/v1/progress'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(progress.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Erro ao criar progresso: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erro ao criar progresso: $e');
      return false;
    }
  }
}
