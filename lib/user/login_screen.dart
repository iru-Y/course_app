import 'package:course_app/app_routes.dart';
import 'package:course_app/notifier/user_notifier.dart';
import 'package:course_app/user/login_repo.dart';
import 'package:course_app/user/user_model.dart';
import 'package:course_app/user/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginRepo _loginRepo = LoginRepo();
  final UserRepo _userRepo = UserRepo();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _performLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    
    if (email.isEmpty || password.isEmpty) {
      _showErrorSnackbar('Preencha todos os campos');
      return;
    }

    try {
      // 1. Faz o login
      await _loginRepo.login(email, password);
      
      // 2. Busca os dados completos do usuário
      final UserModel user = await _userRepo.getUser(email);
      
      // 3. Atualiza o UserNotifier com o UserModel completo
      final userNotifier = Provider.of<UserNotifier>(context, listen: false);
      userNotifier.setUser(user);
      
      // 4. Navega para a tela inicial
      Navigator.pushNamed(context, AppRoute.home);
    } catch (e) {
      _showErrorSnackbar('Erro ao fazer login: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
          padding: EdgeInsets.symmetric(
            horizontal: 13.w, 
            vertical: 16.h
          ),
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
              _buildEmailField(),
              SizedBox(height: 16.h),
              _buildPasswordField(),
              SizedBox(height: 24.h),
              _buildLoginButton(),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'E-mail',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Senha',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _performLogin,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50.h),
      ),
      child: Text(
        'Entrar',
        style: TextStyle(fontSize: 18.sp),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, AppRoute.register),
      child: Text(
        'Criar nova conta',
        style: TextStyle(fontSize: 16.sp),
      ),
    );
  }
}