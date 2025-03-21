import 'package:course_app/notifier/user_notifier.dart';
import 'package:course_app/user/user_model.dart';
import 'package:course_app/user/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    final UserRepo userRepository = UserRepo();
    final userNotifier = Provider.of<UserNotifier>(context).userModel;

    final userEmail = userNotifier.email ?? '';

    return FutureBuilder<UserModel?>(
      future: userRepository.getUser(userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text("Erro: ${snapshot.error}");
        }

        final user = snapshot.data;
        final email = user?.email;
        final cpf = user?.cpf;
        print('cpf $cpf');
        print('email $email');
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  width: 369.w,
                  height: 203.h,
                  child: Column(
                    children: [
                      Text(
                        email ?? 'emeeeeeail@email.com',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
