import 'package:course_app/colors.dart';
import 'package:course_app/widgets/search_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const HomeHeader({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

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
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
      width: double.infinity,
      height: 250.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.school, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Course Platform',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          SearchHeader(
            controller: searchController,
            onChanged: onSearchChanged,
          ),
        ],
      ),
    );
  }
}