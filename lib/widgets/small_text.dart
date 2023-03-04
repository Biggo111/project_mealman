import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SmallText extends StatelessWidget {
  Color? color;
  String text;
  double size;
  double hight;
  SmallText({super.key, this.color, required this.text, this.size=12, this.hight=1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'roboto',
        fontSize: size.sp,
        fontWeight: FontWeight.w400,
        height: hight,
      ),
    );
  }
}