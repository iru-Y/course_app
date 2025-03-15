import 'package:course_app/app_routes.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GestureDetector(
        onTap: () => {Navigator.of(context).pushNamed(AppRoute.profilePage)},
        child: Container(child: Text('Esse é o drawer')),
      ),
    );
  }
}
