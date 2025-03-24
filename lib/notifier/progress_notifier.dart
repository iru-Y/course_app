import 'package:flutter/material.dart';
import 'package:course_app/course/progress_model.dart';
import 'package:course_app/course/progress_repository.dart';

class ProgressNotifier with ChangeNotifier {
  ProgressResponse? progress;

  Future<void> loadProgress(String userId, String courseId) async {
    try {
      final response = await ProgressRepo().getProgress(userId, courseId);
      progress = response;
      notifyListeners();
    } catch (e) {
      print('Erro ao carregar progresso: $e');
      progress = null;
      notifyListeners();
    }
  }
}