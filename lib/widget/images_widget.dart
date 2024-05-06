import 'package:flutter/material.dart';

class ImagesWidget extends StatelessWidget{
  String name;
  double? width;
  double? height;
  BoxFit? fit;
  Color? color;

  ImagesWidget({
    required this.name,
    this.width,
    this.height,
    this.fit,
    this.color,
});

  @override
  Widget build(BuildContext context) => Image.asset(
    "images/$name.png",
    width: width,
    height: height,
    fit: fit,
    color: color,
  );
}