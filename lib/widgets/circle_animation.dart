import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  final Widget child;
  const CircleAnimation({super.key, required this.child});

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 5000));
    _controller.forward();
    _controller.repeat();

    _controller.addStatusListener((status){
      print(status);
      status == AnimationStatus.completed ? _controller.repeat() : null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.stop();
    super.dispose();
    _controller.dispose();
    print('Disposed');
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns:  Tween(begin: 0.0,end: 1.0).animate(_controller),
      child: widget.child,
    );
  }
}