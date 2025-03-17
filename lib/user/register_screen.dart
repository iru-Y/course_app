import 'package:course_app/app_routes.dart';
import 'package:course_app/user/register_repo.dart';
import 'package:course_app/widgets/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    _passwordCheckController.dispose();
    super.dispose();
  }

  // ignore: unused_element
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Digite uma senha';
    if (value.length < 6) return 'Mínimo 6 caracteres';
    if (value != _passwordCheckController.text) return 'Senhas não coincidem';
    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await registerRepo(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _cpfController.text.trim(),
        _passwordController.text,
        _passwordCheckController.text,
      );
     
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.home,
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Crie sua conta',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 36.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 45.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomForm(hintText: "Nome", controller: _nameController),
                      SizedBox(height: 20.h),
                      CustomForm(
                        hintText: "E-mail",
                        controller: _emailController,
                      ),
                      SizedBox(height: 20.h),
                      CustomForm(hintText: "CPF", controller: _cpfController),
                      SizedBox(height: 20.h),
                      CustomForm(
                        hintText: "Senha",
                        controller: _passwordController,
                      ),
                      SizedBox(height: 20.h),
                      CustomForm(
                        hintText: "Repita sua senha",
                        controller: _passwordCheckController,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: GestureDetector(
                    onTap: _isLoading ? null : _submitForm,
                    child: Container(
                      margin: EdgeInsets.only(top: 24.h),
                      width: 342.w,
                      height: 55.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          'Registar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
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
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Já tem uma conta? '),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, AppRoute.login),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Color(0xFF5C4BAF)),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, AppRoute.home),
                      child: Text(
                        'Pular',
                        style: TextStyle(color: Color(0xFF5C4BAF)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
