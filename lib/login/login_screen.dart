import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 9.w),
              child: Text(
                'Crie sua conta',
                style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w700),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('email'),
                TextField(),
                Text('senha'),
                TextField(obscureText: true),
              ],
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
