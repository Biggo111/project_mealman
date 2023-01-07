import 'package:flutter/material.dart';
class BigText extends StatelessWidget {
  Color? color;
  String text;
  double size;
  TextOverflow overflow;
  BigText({super.key, this.color, required this.text, this.size=20, this.overflow= TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'roboto',
        fontSize: size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}