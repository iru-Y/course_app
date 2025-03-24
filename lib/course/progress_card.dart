import 'package:course_app/course/course_model.dart';
import 'package:course_app/course/course_repository.dart';
import 'package:course_app/notifier/course_notifier.dart';
import 'package:course_app/notifier/progress_notifier.dart';
import 'package:course_app/notifier/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressCard extends StatefulWidget {
  const ProgressCard({super.key});

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final courseId = ModalRoute.of(context)!.settings.arguments;
    final progressNotifier = Provider.of<ProgressNotifier>(context);
    final courseRepository = CourseRepository();
    final courseNotifier = Provider.of<CourseNotifier>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      courseNotifier.loadCourse(courseId.toString());
      if (userNotifier.user?.id != null) {
        progressNotifier.loadProgress(
          userNotifier.user!.id!,
          courseNotifier.courseModel!.id!,
        );
      }
    });

    return Consumer(
      builder:
          (context, courseNotifier, _) => Consumer<ProgressNotifier>(
            builder: (context, progressNotifier, _) {
              if (progressNotifier.progress == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final progress = progressNotifier.progress?.progress ;
              final formattedDate =
                  "${progress?.lastAccessedAt?.day}/${progress?.lastAccessedAt?.month}/${progress?.lastAccessedAt?.year}";

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow('Último acesso', formattedDate),
                      _buildInfoRow(
                        'Módulos completados',
                        progress?.completedModules.length.toString(),
                      ),
                      _buildInfoRow(
                        'Vídeos assistidos',
                        progress?.completedVideos.length.toString(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget _buildInfoRow(String? label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label ?? "label", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? "value"),
        ],
      ),
    );
  }
}
