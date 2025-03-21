import 'dart:math';
import 'package:course_app/app_routes.dart';
import 'package:course_app/course/course_model.dart';
import 'package:course_app/course/course_repository.dart';
import 'package:course_app/notifier/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  LinearGradient _randomGradient() {
    final Random random = Random();
    Color baseColor = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    Color darkerColor = Color.fromARGB(
      255,
      (baseColor.red * 0.7).toInt(),
      (baseColor.green * 0.7).toInt(),
      (baseColor.blue * 0.7).toInt(),
    );
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [baseColor, darkerColor],
    );
  }

  @override
  Widget build(BuildContext context) {


    final courseRepository = CourseRepository();

    return FutureBuilder<List<CourseModel>>(
      future: courseRepository.getCourses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar cursos'));
        }

        final courses = snapshot.data;
        if (courses == null || courses.isEmpty) {
          return const Center(child: Text('Nenhum curso encontrado'));
        }

        return SizedBox(
          width: 500.w,
          height: 186.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses.first;
              return SizedBox(
                width: 324.w,
                child: InkWell(
                  onTap:
                      () => {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoute.course, arguments: course.id),
                      },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: _randomGradient(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.only(
                        top: 10.h,
                        bottom: 20.h,
                        right: 20.w,
                        left: 20.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.title ?? 'Sem título',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                course.description ?? 'Sem descrição',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const Spacer(),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Text(
                                  'Preço: ${course.price!}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/loading_circles_blue_gradient.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),

                              borderRadius: BorderRadius.circular(13),
                            ),
                            width: 90.w,
                            height: 90.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
