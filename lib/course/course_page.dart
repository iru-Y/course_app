import 'package:course_app/course/course_model.dart';
import 'package:course_app/course/course_repository.dart';
import 'package:course_app/user/login_model.dart';
import 'package:course_app/user/login_repo.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseRepository courseRepository = CourseRepository();
    final CourseModel courseModel = CourseModel();
    final LoginModel loginModel = LoginModel();
    final LoginRepo loginRepo = LoginRepo();
    fetchMail() {
      
    }

    return FutureBuilder(
      future: courseRepository.getUserByEmail(loginModel.email!),
      builder: (context, snapshot) {
        return Column(children: [Container(child: Column(children: [
                    
                ],
              ))]);
      },
    );
  }
}
