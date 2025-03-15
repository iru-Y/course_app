import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({super.key, this.hintText, this.controller});

  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
