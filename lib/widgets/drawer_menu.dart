import 'package:course_app/app_routes.dart';
import 'package:course_app/user/user_model.dart';
import 'package:course_app/user/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerMenu extends StatelessWidget {
  

  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final String userEmail = ''; 
    final userRepo = UserRepo();

    return FutureBuilder(
      future: userRepo.getUser('email@email.com'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Drawer(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Drawer(
            child: Center(
              child: Text('Erro: ${snapshot.error}'),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Drawer(
            child: Center(child: Text('Nenhum usuário encontrado')),
          );
        }

        final user = snapshot.data!;

        return Drawer(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.w,
              horizontal: 10.h,
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    user.name ?? "eu",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(user.email ?? 'email@email.com'),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Perfil'),
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoute.profilePage,
                    arguments: user,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    user.premiumAccess ?? true 
                      ? Icons.star
                      : Icons.star_border,
                    color: user.premiumAccess ?? true ? Colors.amber : null,
                  ),
                  title: Text(
                    user.premiumAccess ?? false
                      ? 'Conta Premium'
                      : 'Atualizar para Premium',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}