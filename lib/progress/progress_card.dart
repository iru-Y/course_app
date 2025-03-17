import 'package:course_app/colors.dart';
import 'package:course_app/progress/progress_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: gText)
                    ),
                    width: 300,
                    height: 120,
                    padding:  EdgeInsets.symmetric(vertical:  20.h, horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      children: [
                        Text(lastCompletedVideo.title!, style:  TextStyle(
                          color: gText
                        ),),
                        Text(lastCompletedVideo.description!)
                      ],
                    )),
                )
              ],
            
          ),
        );
      },
    );
  }
}
