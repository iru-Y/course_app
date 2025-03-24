import 'package:course_app/app_routes.dart';
import 'package:course_app/course/user_progress.dart';
import 'package:course_app/home/home_screen.dart';
import 'package:course_app/notifier/course_notifier.dart';
import 'package:course_app/notifier/progress_notifier.dart';
import 'package:course_app/notifier/user_notifier.dart';
import 'package:course_app/user/login_screen.dart';
import 'package:course_app/user/profile_user.dart';
import 'package:course_app/user/register_screen.dart';
import 'package:course_app/video/video_player_page.dart';
import 'package:course_app/video/video_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserNotifier()),
       ChangeNotifierProvider(create: (_) => ProgressNotifier()),
         ChangeNotifierProvider(create: (_) => CourseNotifier()),
      
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        routes: {
          AppRoute.register: (context) => const RegisterScreen(),
          AppRoute.login: (context) => const LoginScreen(),
          AppRoute.home: (context) => const HomeScreen(),
          AppRoute.videoUpload: (context) => const VideoUpload(),
          AppRoute.showVideo: (context) => const VideoPlayerPage(),
          AppRoute.profilePage: (context) => const ProfileUser(),
          AppRoute.course: (context) => const UserProgress(),
        },
      ),
    );
  }
}
