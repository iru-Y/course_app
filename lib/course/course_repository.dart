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
        final List<CourseModel> jsonList = jsonDecode(response.body);
        return jsonList;
      } else {
        throw Exception('Falha ao carregar cursos: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro em getCourses: $e');
      rethrow; 
    }
  }
}
