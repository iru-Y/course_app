import 'package:course_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: headerHome,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.elliptical(30.r, 60.r),
          bottomLeft: Radius.elliptical(30.r, 60.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      width: double.infinity,
      height: 250.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.abc, color: Colors.white),
                  Text('Course platform'),
                ],
              ),
              Icon(Icons.add_alert_sharp, color: Colors.white),
            ],
          ),
          SizedBox(height: 80.h),
          Container(
            width: double.infinity,
            height: 54.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Pesquisar por cursos',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
