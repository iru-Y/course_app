import 'package:course_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text('Crie sua conta'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nome'),
                  TextField(),
                  Text('E-mail'),
                  TextField(),
                  Text('Senha'),
                  TextField(),
                  Text('Repita sua senha'),
                  TextField(),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 367.w,
                  height: 67.h,
                  decoration: BoxDecoration(
                    color: loginButton,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text('Continue com seu Email'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
