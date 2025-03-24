import 'package:course_app/course/course_model.dart';
import 'package:course_app/course/course_repository.dart';
import 'package:flutter/material.dart';

class CourseNotifier with ChangeNotifier {
  CourseModel? _courseModel;

  CourseModel? get courseModel => _courseModel;

  Future<void> loadCourse(String courseId) async {
    try {
      final course = await CourseRepository().getCourseById(courseId);
      _courseModel = course;
      notifyListeners();
    } catch (e) {
      Exception(e);
    }
  }

  void setCourse(CourseModel course) {
    _courseModel = course;
    notifyListeners();
  }
}
