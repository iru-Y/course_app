import 'package:course_app/progress/progress_card.dart';
import 'package:course_app/widgets/card_video.dart';
import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
                ShowCardVideo()
          ],
        ),
      ),
    );
  }
}