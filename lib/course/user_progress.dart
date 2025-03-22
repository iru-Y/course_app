// course_page.dart
import 'package:course_app/course/course_card.dart';
import 'package:course_app/course/progress_card.dart';
import 'package:course_app/notifier/user_notifier.dart';
import 'package:course_app/user/user_model.dart';
import 'package:course_app/user/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserProgress extends StatelessWidget {
  const UserProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final userEmail = userNotifier.user!.email;
    final userRepository = UserRepo();

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<UserModel?>(
          future: userRepository.getUser(userEmail!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            final user = snapshot.data;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 90.h),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 60.h,
                      horizontal: 25.w,
                    ),
                    width: 369.w,
                    height: 203.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF5340B0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.email ?? 'sem email',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          user?.premiumAccess == true
                              ? 'Premium: sim'
                              : 'Premium: não',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          user?.paidAccess == true
                              ? 'Acesso pago: sim'
                              : 'Acesso pago: não',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text('Assistindo agora'),
                  _buildProgress()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _buildProgress() {
 return   ProgressCard();
  }
}
