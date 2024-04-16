import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget{
  String text;
  double size;
  Color color;
  TextAlign? textAlign;
  FontWeight? fontWeight;

  TextWidget({
    required this.text,
    required this.size,
    required this.color,
    this.textAlign,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) => Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight
      ),
    textAlign: textAlign,
  );
}