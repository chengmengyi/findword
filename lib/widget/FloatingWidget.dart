import 'package:flutter/material.dart';

class FloatingWidget extends StatefulWidget {
  Widget child;
  FloatingWidget({required this.child});

  @override
  State<StatefulWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    animation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0.5)).animate(controller);
  }

  @override
  Widget build(BuildContext context) => SlideTransition(
    position: animation,
    child:widget.child,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}