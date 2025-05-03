import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:guesswork/core/presentation/extension/animation_utils.dart';
import 'package:image_firework/image_firework.dart';

class PointsWidget extends StatefulWidget {
  final int points;

  const PointsWidget({super.key, required this.points});

  @override
  State<PointsWidget> createState() => PointsWidgetState();
}

class PointsWidgetState extends State<PointsWidget> {
  String get stringPoints => widget.points.toString();
  double textFontSize = 60;
  double textBorderStokeWidth = 5;
  Color textBorderColor = Colors.black;
  Color textColor = Colors.white;

  Duration inflatingDuration = 1500.ms;

  static List<String> animatingImageUriList = ['assets/images/coin.webp'];

  List<int> animatingImageCountList = [0];

  ImageFireWorkManager imageFireWorkManager = ImageFireWorkManager(
    animatingImageUriList: animatingImageUriList,
  );

  late AudioPlayer inflatingPlayer;
  late AudioPlayer partyPopperPlayer;

  @override
  void initState() {
    super.initState();
    inflatingPlayer = AudioPlayer();
    inflatingPlayer.setVolume(0.25);
    inflatingPlayer.setReleaseMode(ReleaseMode.release);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await inflatingPlayer.setSource(AssetSource('sounds/inflating.mp3'));
      // await player.resume();
    });

    partyPopperPlayer = AudioPlayer();
    partyPopperPlayer.setVolume(0.25);
    partyPopperPlayer.setReleaseMode(ReleaseMode.release);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await partyPopperPlayer.setSource(AssetSource('sounds/party_popper.mp3'));
      // await player.resume();
    });
  }

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
                        ..color = textBorderColor,
                ),
                duration: inflatingDuration,
                curve: Curves.linear,
                child: Text(stringPoints),
              ),

              AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontSize: textFontSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                duration: inflatingDuration,
                curve: Curves.linear,
                child: Text(stringPoints),
              ),
            ],
          ).happyBounce.animate(),
    );
  }

  addFireworkBomb(Offset generatePosition) async {
    inflatingPlayer.resume();
    setState(() {
      textColor = Colors.amber;
      textBorderColor = Colors.amber;
      textFontSize = 120;
    });

    await Future.delayed(inflatingDuration);
    inflatingPlayer.stop();

    partyPopperPlayer.resume();
    setState(() {
      animatingImageCountList = [50];
      imageFireWorkManager.addFireworkWidget(
        offset: generatePosition,
        animatingImageCountList: animatingImageCountList,
      );
    });
  }
}
