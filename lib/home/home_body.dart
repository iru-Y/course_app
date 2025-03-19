import 'package:course_app/course/course_card.dart';
import 'package:course_app/course/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatelessWidget {
  final List<CourseModel> courses;

  const HomeBody({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionHeader(title: 'Confira os novos cursos!', buttonText: 'Ver todos'),
        _buildCourseList(),
        const _SectionHeader(title: 'Seus cursos', buttonText: 'Ver todos'),
        _buildCourseList(),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildCourseList() {
    return SizedBox(
      width: double.infinity,
      height: 186.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseCard();
        },
      ),
    );
  }


  LinearGradient _randomGradient() {
    return const LinearGradient(
      colors: [Colors.blue, Colors.indigo],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String buttonText;

  const _SectionHeader({
    required this.title,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {

            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
