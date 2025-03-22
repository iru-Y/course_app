// login_screen.dart
import 'package:course_app/app_routes.dart';
import 'package:course_app/notifier/user_notifier.dart';
import 'package:course_app/user/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginRepo loginRepo = LoginRepo();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _performLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    try {
      // Simulação de login bem-sucedido
      await loginRepo.login(email, password);
      
      // Atualiza o UserNotifier com o email
      final userNotifier = Provider.of<UserNotifier>(context, listen: false);
      userNotifier.setEmail(email);
      
      Navigator.pushNamed(context, AppRoute.home);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: _performLogin,
                child: Text('Entrar'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoute.register),
                child: Text('Criar nova conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}