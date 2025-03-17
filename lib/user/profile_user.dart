import 'package:course_app/widgets/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back),
                  Text(
                    'Editar seu perfil',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            SizedBox(height:  34.h,),
            CustomForm(
              hintText: 'Nome completo',
              controller: fullNameController,
            ),
            CustomForm(hintText: 'Email', controller: fullNameController),
            CustomForm(hintText: 'cpf', controller: fullNameController),
           
          ],
        ),
      ),
    );
  }
}