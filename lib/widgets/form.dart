import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({super.key, this.text, this.controller});

  final String? text;
  final  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('$text'), TextField(controller: controller)],
    );
  }
}
