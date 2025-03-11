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
              TextButton(onPressed: ()=>{
                Navigator.of(context).pushNamed(AppRoute.videoUpload)
              }, child: Text('Video upload')),
              Text('Seus cursos'),
              TextButton(onPressed: () => {}, child: Text('Ver todos')),
              
            ],
          ),
        ],
    );
  }
}
