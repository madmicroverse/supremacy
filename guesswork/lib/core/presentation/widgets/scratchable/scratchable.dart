import 'dart:math';

import 'package:async/async.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gaimon/gaimon.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/presentation/extension/offset_utils.dart';

class ScratchableWidget extends StatefulWidget {
  final GamesSettings? gamesSettings;
  final Set<Offset> revealedPoints;
  final double width;
  final double height;
  final double brushRadius;
  final Widget background;
  final Widget foreground;
  final Function(double progress, Set<Offset> revealedPoints) revealedListener;

  const ScratchableWidget({
    super.key,
    required this.gamesSettings,
    required this.revealedPoints,
    required this.width,
    required this.height,
    required this.background,
    required this.foreground,
    required this.brushRadius,
    required this.revealedListener,
  });

  @override
  ScratchableState createState() => ScratchableState();

  void reveal() {}
}

class ScratchableState extends State<ScratchableWidget>
    with SingleTickerProviderStateMixin {
  CancelableOperation<void>? cancelableOperation;

  late AudioPlayer player;

  late Path _revealedPath;
  final int _samplingResolution = 200;
  late int _pathPointsTotal;
  final Set<Offset> _pathPoints = {};
  late double xStep;
  late double yStep;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _revealedPath =
        Path()..addRect(Rect.fromLTWH(0, 0, widget.width, widget.height));

    xStep = widget.width / _samplingResolution;
    yStep = widget.height / _samplingResolution;

    for (var x = 0; x < _samplingResolution; x++) {
      for (var y = 0; y < _samplingResolution; y++) {
        _pathPoints.add(Offset(x * xStep, y * yStep));
      }
    }

    _pathPointsTotal = _pathPoints.length;

    _controller = AnimationController(duration: 1500.ms, vsync: this);
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    player = AudioPlayer();

    player.setReleaseMode(ReleaseMode.loop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('sounds/scratching2.mp3'));
    });

    Future.microtask(() async {
      for (var point in widget.revealedPoints) {
        _addPoint(point);
        await Future.delayed(0.ms);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (details) {
          _addPoint(details.localPosition);
          if (widget.gamesSettings?.sound ?? false) {
            player.resume();
          }
          cancelableOperation = CancelableOperation.fromFuture(
            Future.microtask(() async {
              while (true) {
                await Future.delayed(200.ms);
                if (cancelableOperation?.isCanceled ?? false) break;
                Gaimon.heavy();
              }
            }),
          );
        },
        onPanUpdate: (details) {
          _addPoint(details.localPosition);
        },
        onPanEnd: (details) {
          player.stop();
          cancelableOperation?.cancel();
        },
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            widget.background,
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return ClipPath(
                  clipper: HoleClipper(_revealedPath, _animation.value),
                  child: widget.foreground,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Path _addPoint(Offset pos) {
    widget.revealedPoints.add(pos);

    final newReveal =
        Path()..addOval(
          Rect.fromCircle(
            center: Offset(pos.dx, pos.dy),
            radius: widget.brushRadius,
          ),
        );

    final revealedPath = Path.combine(
      PathOperation.difference,
      _revealedPath,
      newReveal,
    );

    _pathPoints.removeWhere(
      (checkpoint) => _inCircle(checkpoint, pos, widget.brushRadius),
    );

    widget.revealedListener(reveledRatio, widget.revealedPoints);

    setState(() {
      _revealedPath = revealedPath;
    });
    return _revealedPath;
  }

  bool _inCircle(Offset center, Offset point, double radius) {
    final dX = center.dx - point.dx;
    final dY = center.dy - point.dy;
    final h = dX * dX + dY * dY;
    return h <= pow(radius, 2);
  }

  double get reveledRatio => 1 - _pathPoints.length / _pathPointsTotal;

  void reveal() {
    _controller.forward();
  }

  List<Map<String, double>> getConcealedPoints() {
    return widget.revealedPoints.toJson();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    if ((cancelableOperation?.isCanceled ?? false) ||
        (cancelableOperation?.isCompleted ?? false)) {
      cancelableOperation?.cancel();
    }
    super.dispose();
  }
}

class HoleClipper extends CustomClipper<Path> {
  Path path;
  double animVal;

  HoleClipper(this.path, double this.animVal);

  @override
  Path getClip(Size size) {
    final matrix4 = Matrix4.identity()..translate(0.0, size.height * animVal);
    return path.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
