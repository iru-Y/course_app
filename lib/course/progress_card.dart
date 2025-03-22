import 'package:course_app/course/progress_model.dart';
import 'package:course_app/course/progress_repository.dart';
import 'package:course_app/notifier/progress_notifier.dart';
import 'package:course_app/notifier/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final progressNotifier = Provider.of<ProgressNotifier>(context);
    final courseId = ModalRoute.of(context)!.settings.arguments as String;

    // Carregar progresso quando o widget for construído
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userNotifier.user?.id != null) {
        progressNotifier.loadProgress(userNotifier.user!.id!, courseId);
      }
    });

    return Consumer<ProgressNotifier>(
      builder: (context, progressNotifier, _) {
        if (progressNotifier.progress == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final progress = progressNotifier.progress!;
        final formattedDate = 
          "${progress.lastAccessedAt.day}/${progress.lastAccessedAt.month}/${progress.lastAccessedAt.year}";

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoRow('Último acesso', formattedDate),
                _buildInfoRow('Módulos completados', progress.completedModules.length.toString()),
                _buildInfoRow('Vídeos assistidos', progress.completedVideos.length.toString()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}