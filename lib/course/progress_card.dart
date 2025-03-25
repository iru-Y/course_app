import 'package:course_app/colors.dart';
import 'package:course_app/course/course_model.dart';
import 'package:course_app/course/course_repository.dart';
import 'package:course_app/notifier/course_notifier.dart';
import 'package:course_app/notifier/progress_notifier.dart';
import 'package:course_app/notifier/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
        progressNotifier.getProgressNotifier(
          userNotifier.user!.id!,
          courseNotifier.courseModel?.id ?? '',
        );
        progressNotifier.getProgressPercentageNotifier(
          userNotifier.user!.id!,
          courseNotifier.courseModel?.id ?? '',
        );
      }
    });

    return Consumer<CourseNotifier>(
      builder: (context, courseNotifier, _) {
        return Consumer<ProgressNotifier>(
          builder: (context, progressNotifier, _) {
            // if (progressNotifier.progress == null 
            //    ) {
            //   return const Center(child: CircularProgressIndicator());
            // }

            final progress = progressNotifier.progress?.progress;
            final percentage = progressNotifier.progress?.percentage ?? "0%";
            final formattedDate = progress?.lastAccessedAt != null
                ? "${progress!.lastAccessedAt!.day}/${progress.lastAccessedAt!.month}/${progress.lastAccessedAt!.year}"
                : "Nunca acessado";

            if (progress?.completedVideos.isEmpty ?? true) {
              return Center(
                child: Text(
                  "Nenhum vídeo concluído ainda",
                  style: TextStyle(
                    color: gText,
                    fontSize: 16.sp,
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: progress?.completedVideos.length ?? 0,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                width: 369.w,
                height: 178.h,
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            progress?.completedVideos[index]?.title ??
                                "Sem título",
                            style: TextStyle(
                              color: gText,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            progress?.completedVideos[index]?.description ??
                                "Sem descrição",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Último acesso: $formattedDate',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Center(
                        child: CircularPercentIndicator(
                          radius: 30.0,
                          lineWidth: 5.0,
                          percent: (double.tryParse(percentage.replaceAll('%', '')) ?? 0.0) / 100.0,
                          center: Text(
                            percentage,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          progressColor: customPurple,
                          backgroundColor: customPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}