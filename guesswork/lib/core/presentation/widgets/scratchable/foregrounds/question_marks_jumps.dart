import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuestionMarksJumps extends StatelessWidget {
  final Random _random = Random();
  final double _width;

  final double _height;

  QuestionMarksJumps(this._width, this._height, {super.key});

  @override
  Widget build(BuildContext context) {
    final List<Offset> points = [];

    double samplingResolution = 5.0;

    double xStep = _width / samplingResolution;
    double yStep = _height / samplingResolution;

    for (var x = 0; x < samplingResolution; x++) {
      for (var y = 0; y < samplingResolution; y++) {
        points.add(Offset(x * xStep, y * yStep));
      }
    }

    double aspectRatio = _width / _height;
    double offset = 30.0;
    double xOffset = offset * aspectRatio;
    double yOffset = offset * (1 / aspectRatio);
    double xRandomNear() => xOffset + 2 * xOffset * _random.nextDouble();
    double yRandomNear() => yOffset + 2 * yOffset * _random.nextDouble();

    return Stack(
      children: [
        ...points.map((point) {
          Duration delayAndDuration = (3000 + 5000.0 * _random.nextDouble()).ms;
          return Positioned(
            left: point.dx + xRandomNear(),
            top: point.dy + yRandomNear(),
            child: Text("?", style: TextStyle(color: Colors.white))
                .animate(onPlay: (controller) => controller.repeat())
                .effect(duration: delayAndDuration)
                .scaleXY(begin: 4, end: 3 + ((5 * _random.nextDouble())))
                // .slideX(curve: Curves.easeOut, begin: -4, end: 4)
                .slideY(curve: Curves.bounceOut, begin: -offset, end: 4),
          );
        }),
      ],
    );
  }
}
