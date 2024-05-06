import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget{
  String text;
  double size;
  Color color;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  double? height;

  TextWidget({
    required this.text,
    required this.size,
    required this.color,
    this.textAlign,
    this.fontWeight,
    this.height,
  });

  @override
  Widget build(BuildContext context) => Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        height: height
      ),
    textAlign: textAlign,
  );
}