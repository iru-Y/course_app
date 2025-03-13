import 'package:course_app/widgets/card_video.dart';
import 'package:flutter/material.dart';

import '../app_routes.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Seus cursos'),
            TextButton(onPressed: () => {}, child: Text('Ver todos')),
          ],
        ),
        ShowCardVideo(),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(child: Text('Cursos salvos'), onPressed: () => {}),
              TextButton(child: Text('Ver todos'), onPressed: () => {}),
            ],
          ),
        ),
        ShowCardVideo(),
      ],
    );
  }
}
