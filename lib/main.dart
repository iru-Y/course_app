import 'package:course_app/app_routes.dart';
import 'package:course_app/login/login_screen.dart';
import 'package:course_app/login/register_screen.dart';
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
        routes: {
          AppRoute.register: (context) => const RegisterScreen(),
          AppRoute.login: (context) => const LoginScreen(),
        },
      ),
    );
  }
}
