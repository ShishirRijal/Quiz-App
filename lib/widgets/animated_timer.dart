import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/resources/routes_manager.dart';

import '../services/quiz.dart';
import '../services/resources/style_manger.dart';

class AnimatedTimer extends StatefulWidget {
  const AnimatedTimer({
    Key? key,
    required this.scaleFactor,
    required this.time,
  }) : super(key: key);
  final double scaleFactor;
  final int time;
  @override
  State<AnimatedTimer> createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Color color;
  late int value;
  late int time;
  late Animation _progress;
  late Animation _time;
  @override
  void initState() {
    super.initState();
    time = widget.time;
    value = widget.time;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time));
    _progress = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _time = IntTween(begin: time, end: 0).animate(_controller);
    _animation =
        ColorTween(begin: Colors.green, end: Colors.red).animate(_controller)
          ..addListener(() {
            setState(() {
              value = _time.value;
            });
          });

    _controller.forward();
  }

  //
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (value == 0) {
    //   Navigator.pushReplacementNamed(context, Routes.resultRoute);
    // }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: CircularPercentIndicator(
        backgroundColor: Colors.white54,
        radius: 50.0,
        lineWidth: 8.0,
        percent: _progress.value,
        progressColor: _animation.value,
        animateFromLastPercent: true,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          value < 10 ? '0$value' : '$value',
          style: getBoldTextStyle(
            color: ColorManager.primary,
          ),
          textScaleFactor: widget.scaleFactor,
        ),
      ),
    );
  }
}
