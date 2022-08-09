import 'package:flutter/material.dart';
import 'package:freelance_dxb/style/style.dart';

class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final double height;

  const PrimaryText({
    Key? key,
    required this.text,
    this.fontWeight = FontWeight.w400,
    this.color = AppColors.primary,
    this.size = 20,
    this.height = 1.3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        height: height,
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}

Color bgColor = const Color(0xffF4F4F4);
Color txtColor = Color.fromARGB(255, 196, 187, 187);
// ignore: prefer_const_constructors
Color wlcBtnColor = Color.fromARGB(255, 240, 67, 67);
Color greyishColor = const Color(0xffE8E7E7);
