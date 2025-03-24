import 'dart:convert';
import 'package:course_app/api_path.dart';
import 'package:course_app/course/course_model.dart';
import 'package:http/http.dart' as http;

class CourseRepository {
  Future<List<CourseModel>> getCourses() async {
    try {
      final response = await http.get(Uri.parse("$apiPath/v1/course"));

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        final List<dynamic> coursesList = jsonResponse['courses'];

        return coursesList.map((json) => CourseModel.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar cursos: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro em getCourses: $e');
      rethrow;
    }
  }

  Future<CourseModel> getCourseById(String id) async {
    try {
      final response = await http.get(Uri.parse('$apiPath/v1/course/$id'));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final course = CourseModel.fromJson(jsonResponse['course']);
        return course;
      } else {
        throw Exception(
          'Falha ao carregar cursos por id: ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
