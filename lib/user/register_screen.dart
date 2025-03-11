import 'package:course_app/app_routes.dart';
import 'package:course_app/colors.dart';
import 'package:course_app/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordCheckController = TextEditingController();
    final cpfController = TextEditingController();
    final emailController = TextEditingController();

    Future<void> sendRegister () async{
      
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                'Crie sua conta',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 36.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 45.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  greyText("Nome", tMargin: 20.sp),
                  TextField(controller: nameController,),
                  SizedBox(height: 20.h),
                  greyText('E-mail', tMargin: 20.sp),
                  TextField(controller: emailController),
                  SizedBox(height: 20.h),
                  greyText('Senha', tMargin: 20.sp),
                  TextField(controller: passwordController,),
                  SizedBox(height: 20.h),
                  greyText('Repita sua senha', tMargin: 20.sp),
                  TextField(controller: passwordCheckController,),
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
                  child: Center(
                    child: Text(
                      'Continue com seu Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.sp),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          'ou',
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Já tem uma conta? '),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoute.login);
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Color(0xFF5C4BAF)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoute.home);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Color(0xFF5C4BAF)),
                      )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
