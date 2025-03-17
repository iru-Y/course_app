import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback navigador;
  const DefaultButton({super.key, required this.text, required this.navigador});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigador, // Corrigido a chamada do callback
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
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}