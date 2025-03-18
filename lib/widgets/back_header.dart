import 'package:course_app/app_routes.dart';
import 'package:flutter/material.dart';

class BackHeader extends StatelessWidget {
  final String? textHeader;
  const BackHeader({super.key, this.textHeader});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
                        onTap: ()=> {
                          Navigator.of(context).popAndPushNamed(AppRoute.home)
                        },
                        child: Icon(Icons.arrow_back),
                     ),
                     SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                      Text(
                        '$textHeader',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                      )
      ],
    );
  }
}