import 'package:course_app/home/home_body.dart';
import 'package:course_app/home/home_header.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              HomeBody()
            ],
          ),
        ),
      ),
    );
  }
}