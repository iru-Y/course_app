import 'package:course_app/notifier/user_notifier.dart';
import 'package:course_app/user/user_model.dart';
import 'package:course_app/user/user_repo.dart';
import 'package:flutter/material.dart';
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
      future: userRepository.getUserByEmail(userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text("Erro: ${snapshot.error}");
        }

        final user = snapshot.data;
        final email = user?.email;
        print('email $email');
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Center(
                  child: Container(
                    child: Column(children: [Text(email ?? 'emeeeeeail@email.com')]),
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
