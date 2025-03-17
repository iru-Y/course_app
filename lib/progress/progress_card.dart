import 'package:course_app/progress/progress_repository.dart';
import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ProgressRepository progressRepository = ProgressRepository();
    final userId = '';
    final courseId = '';

    return FutureBuilder(
      future: progressRepository.getProgress(userId, courseId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar cursos'));
        }

        final progress = snapshot.data;
        if (progress == null) {
          return const Center(child: Text('Nenhum curso encontrado'));
        }
        final lastCompletedVideo = progress.completedVideos!.first;
        return Scaffold(
          body: Column(
            children: [
              Text(lastCompletedVideo.title!)
            ],
          ),
        );
      },
    );
  }
}
