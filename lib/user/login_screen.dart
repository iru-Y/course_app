import 'package:course_app/app_routes.dart';
import 'package:course_app/user/login_repo.dart';
import 'package:course_app/user/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    Future<void> getLogin() async {
      final email = emailController.text;
      final password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, preencha todos os campos')),
        );
        return;
      }

      try {
        await login(email, password);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao fazer login: $e')));
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              Text(
                'Crie sua conta',
                style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 24.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email'),
                  TextField(controller: emailController),
                  SizedBox(height: 16.h),
                  Text('Senha'),
                  TextField(controller: passwordController, obscureText: true),
                ],
              ),
              SizedBox(height: 24.h),
              ElevatedButton(onPressed: () async{
                  await getLogin();
                   Navigator.of(context).pushNamed(AppRoute.home);
              },
               child: Text('Entrar')),
            ],
          ),
        ),
      ),
    );
  }
}
