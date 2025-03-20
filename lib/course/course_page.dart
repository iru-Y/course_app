import 'package:course_app/course/course_repository.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});


  @override
  Widget build(BuildContext context) {
    final  CourseRepository courseRepository = CourseRepository();
    return  FutureBuilder(
      future:  courseRepository.getCourses(),
      builder: (context, snapshot) {
        return Column(
        children: [
            Container(
              child:  Column(
                children: [
                    
                ],
              ),
            )
        ],
      );
      },
    );
  }
}