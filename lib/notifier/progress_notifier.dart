import 'package:flutter/material.dart';
import 'package:course_app/course/progress_model.dart';
import 'package:course_app/course/progress_repository.dart';

class ProgressNotifier with ChangeNotifier {
  ProgressModel? _progress;
  final ProgressRepo _progressRepo = ProgressRepo();

  ProgressModel? get progress => _progress;

  Future<void> loadProgress(String userId, String courseId) async {
    try {
      final response = await _progressRepo.getProgress(userId, courseId);
      _progress = response.progress;
      notifyListeners();
    } catch (e) {
      print("Erro ao carregar progresso: $e");
      rethrow;
    }
  }

  void clearProgress() {
    _progress = null;
    notifyListeners();
  }
}