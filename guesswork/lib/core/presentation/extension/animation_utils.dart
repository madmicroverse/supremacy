import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:guesswork/core/presentation/widgets/greyscale.dart';

extension WidgetAnimations on Widget {
  Widget get happyBounce {
    final durationInMillis = 2000;
    return this
        .animate(onPlay: (controller) => controller.repeat())
        .shake(duration: durationInMillis.ms, curve: Curves.linear, hz: 0.25)
        .scaleXY(
          duration: (durationInMillis / 2).ms,
          begin: 1,
          end: 1.1,
          curve: Curves.bounceIn,
        )
        .scaleXY(
          delay: (durationInMillis / 2).ms,
          duration: (durationInMillis / 2).ms,
          begin: 1.1,
          end: 1,
          curve: Curves.bounceOut,
        );
  }

  Widget greyscaleShimmer(bool isLoading) {
    var result = this;

    if (isLoading) {
      result = Greyscale(child: this);
    }
    final durationInMillis = 1500;
    return result
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: durationInMillis.ms, curve: Curves.easeInCubic);
  }

  Widget get shimmer {
    final durationInMillis = 1500;
    return animate(
      onPlay: (controller) => controller.repeat(),
    ).shimmer(duration: durationInMillis.ms, curve: Curves.easeInCubic);
  }
}
