import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LetterBurst extends StatelessWidget {
  final double width;
  final double height;
  final String letter;
  final Widget background;
  final Color color;

  LetterBurst({
    super.key,
    required this.width,
    required this.height,
    required this.letter,
    required this.background,
    required this.color,
  });

  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    final List<Offset> points = [];

    double samplingResolution = 0.019 * width;

    double xStep = width / samplingResolution;
    double yStep = height / samplingResolution;

    for (var x = 0; x < samplingResolution; x++) {
      for (var y = 0; y < samplingResolution; y++) {
        points.add(Offset(x * xStep, y * yStep));
      }
    }

    double aspectRatio = width / height;
    double offset = 20.0;
    double xOffset = offset * aspectRatio;
    double yOffset = offset * (1 / aspectRatio);
    double xRandomNear() => -xOffset + 2 * xOffset * _random.nextDouble();
    double yRandomNear() => -yOffset + 2 * yOffset * _random.nextDouble();

    return Stack(
      children: [
        background,

        ...points.map((point) {
          Duration delayAndDuration = (2000 + 4000.0 * _random.nextDouble()).ms;

          return Positioned(
            left: point.dx + xRandomNear(),
            top: point.dy + yRandomNear(),
            child: Text(letter, style: TextStyle(color: color))
                .animate(onPlay: (controller) => controller.repeat())
                .effect(
                  // delay: (3000 * _random.nextDouble()).ms,
                  duration: delayAndDuration,
                )
                .shake(
                  curve: Curves.easeInOutCubic,
                  hz: 1.5 + (2.5 * _random.nextDouble()),
                )
                .scaleXY(begin: 0, end: 2 + ((6 * _random.nextDouble())))
                .fadeOut(begin: 1, delay: 200.0.ms),
          );
        }),
      ],
    );
  }
}
