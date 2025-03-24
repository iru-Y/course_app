import 'package:course_app/course/course_model.dart';
import 'package:course_app/course/course_repository.dart';
import 'package:course_app/notifier/course_notifier.dart';
import 'package:course_app/notifier/progress_notifier.dart';
import 'package:course_app/notifier/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

              final progress = progressNotifier.progress?.progress;
              final formattedDate =
                  "${progress?.lastAccessedAt?.day}/${progress?.lastAccessedAt?.month}/${progress?.lastAccessedAt?.year}";

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: progress?.completedVideos.length,
                itemBuilder:
                    (context, index) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      width: 369.w,
                      height: 178.h,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              progress!.completedVideos[index]!.title ??
                                  "Sem vídeos completos",
                            ),
                             Text(
                              progress!.completedVideos[index]!.description ??
                                  "Sem vídeos completos",
                            ),
                           
                          ],
                        ),
                      ),
                    ),
              );
            },
          ),
    );
  }
}
