import 'dart:convert';
import 'package:course_app/api_path.dart';
import 'package:course_app/course/course_model.dart';
import 'package:http/http.dart' as http;

class CourseRepository {
  Future<List<CourseModel>> getCourses() async {
    try {
      final response = await http.get(Uri.parse("$apiPath/v1/course"));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return [CourseModel.fromJson(json)];
      }
      return [];
    } catch (e) {
      print('Erro ao buscar cursos: $e');
      return [];
    }
  }
}
