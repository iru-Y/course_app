import 'package:course_app/app_routes.dart';
import 'package:course_app/user/login_repo.dart';
import 'package:course_app/widgets/custom_form.dart';
import 'package:course_app/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _performLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    try {
      await login(email, password);
      Navigator.pushNamed(context, AppRoute.home);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer login: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Faça seu login',
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              CustomForm(
                hintText: 'E-mail',
                controller: _emailController,
              ),
              SizedBox(height: 16.h),
              CustomForm(
                hintText: 'Senha',
                controller: _passwordController,
              ),
              SizedBox(height: 24.h),
              Center(
                child: DefaultButton(
                  text: 'Entrar',
                  navigador: _performLogin,
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoute.register),
                  child: Text('Criar nova conta'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}