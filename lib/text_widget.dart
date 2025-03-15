import 'package:course_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 Widget greyText (String text, {double? tMargin}) {
  return Container(
    margin: EdgeInsets.only(top: tMargin!),
    child: Text(text, style: TextStyle(color: gText, fontSize: 18.sp)),
  );
}
