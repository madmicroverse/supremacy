import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:guesswork/core/presentation/extension/animation_utils.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:image_firework/image_firework.dart';

class PointsWidget extends StatefulWidget {
  final int points;
  final Duration duration;

  const PointsWidget({super.key, required this.points, required this.duration});

  @override
  State<PointsWidget> createState() => PointsWidgetState();
}

class PointsWidgetState extends State<PointsWidget> {
  String get stringPoints => widget.points.toString();
  double textFontSize = 60;
  double textBorderStokeWidth = 5;
  bool isInflating = false;

  static List<String> animatingImageUriList = ['assets/images/coin.webp'];

  List<int> animatingImageCountList = [0];

  ImageFireWorkManager imageFireWorkManager = ImageFireWorkManager(
    animatingImageUriList: animatingImageUriList,
  );

  @override
  Widget build(BuildContext context) {
    if (animatingImageCountList.any((x) => x > 0)) {
      return IgnorePointer(
        child: Stack(
          children: imageFireWorkManager.fireworkWidgets.values.toList(),
        ),
      );
    }

    return Align(
      alignment: Alignment.center,
      child:
          Stack(
            children: [
              AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontSize: textFontSize,
                  fontWeight: FontWeight.bold,
                  foreground:
                      Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = textBorderStokeWidth
                        ..color =
                            isInflating
                                ? context.gamesColors.golden
                                : context.colorScheme.shadow,
                ),
                duration: widget.duration,
                curve: Curves.linear,
                child: Text(stringPoints),
              ),

              AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontSize: isInflating ? 120 : 60,
                  fontWeight: FontWeight.bold,
                  color:
                      isInflating
                          ? context.gamesColors.golden
                          : context.colorScheme.onPrimary,
                ),
                duration: widget.duration,
                curve: Curves.linear,
                child: Text(stringPoints),
              ),
            ],
          ).happyBounce.animate(),
    );
  }

  addFireworkBomb(BuildContext context, Offset generatePosition) async {
    setState(() {
      isInflating = true;
      textFontSize = 120;
    });
    await Future.delayed(widget.duration);
    setState(() {
      animatingImageCountList = [50];
      imageFireWorkManager.addFireworkWidget(
        offset: generatePosition,
        animatingImageCountList: animatingImageCountList,
      );
    });
  }
}
