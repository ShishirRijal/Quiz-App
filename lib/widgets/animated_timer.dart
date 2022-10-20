import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../services/resources/style_manger.dart';

class AnimatedTimer extends StatefulWidget {
  const AnimatedTimer({
    Key? key,
    required this.scaleFactor,
  }) : super(key: key);
  final double scaleFactor;
  @override
  State<AnimatedTimer> createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Color color;
  int time = 5;
  late Animation _time;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time));
    _animation =
        Tween<Color>(begin: Colors.green, end: Colors.red).animate(_controller);
    _time = Tween<int>(begin: time, end: 0).animate(_controller);
    // _controller.forward();
    // _controller.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: CircularPercentIndicator(
        backgroundColor: Colors.white,
        radius: 50.0,
        lineWidth: 7.0,
        reverse: true,
        percent: 0.75,
        progressColor: ColorManager.primary,
        animateFromLastPercent: true,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          '45',
          style: getBoldTextStyle(
            color: ColorManager.primary,
          ),
          textScaleFactor: widget.scaleFactor,
        ),
      ),
    );
  }
}
