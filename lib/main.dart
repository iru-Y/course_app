import 'package:course_app/app_routes.dart';
import 'package:course_app/home/home_screen.dart';
import 'package:course_app/user/login_screen.dart';
import 'package:course_app/user/register_screen.dart';
import 'package:course_app/video/video_player_page.dart';
import 'package:course_app/video/video_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
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
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
        routes: {
          AppRoute.register: (context) => const RegisterScreen(),
          AppRoute.login: (context) => const LoginScreen(),
          AppRoute.home: (context) => const HomeScreen(),
          AppRoute.videoUpload: (context) => VideoUpload(),
          AppRoute.showVideo: (context) => VideoPlayerPage()
        },
        
      ),
    );
  }
}
