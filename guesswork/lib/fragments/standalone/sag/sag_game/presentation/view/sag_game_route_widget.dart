import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/extension/sag_game.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/presentation/view/points_widget.dart';

import '../bloc/sag_game_be.dart';
import '../bloc/sag_game_bloc.dart';
import '../bloc/sag_game_bsc.dart';

SAGGameBloc _bloc(BuildContext context) => context.read<SAGGameBloc>();

class SAGGameRouteWidget extends StatefulWidget {
  final PreferredSizeWidget appBarWidget;

  const SAGGameRouteWidget({super.key, required this.appBarWidget});

  @override
  State<SAGGameRouteWidget> createState() => _SAGGameRouteWidgetState();
}

class _SAGGameRouteWidgetState extends State<SAGGameRouteWidget> {
  final GlobalKey<PointsWidgetState> pointsKey = GlobalKey<PointsWidgetState>();

  bool arePointsClaimed = false;

  Duration claimDuration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBarWidget,
      body: BlocBuilder<SAGGameBloc, SAGGameBSC>(
        builder: (context, state) {
          if (!state.isSAGGameCompleted) {
            return Container();
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // GameSetBlocAppBar(),
                  CustomPaint(painter: RotaryPainter(), size: Size.infinite)
                      .animate(onPlay: (controller) => controller.repeat())
                      .scaleXY(begin: 4, end: 4)
                      .rotate(
                        duration: Duration(minutes: 100),
                        begin: 0,
                        end: 20 * pi,
                      ),

                  if (arePointsClaimed)
                    Align(
                      alignment: Alignment.center,
                      child: FilledButton(
                        onPressed: () {
                          _bloc(context).add(PopSAGGameBE());
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.amber,
                          ),
                        ),
                        child: Text("More games"),
                      ),
                    ).animate().fadeIn(duration: 1500.ms, begin: 0),

                  if (!arePointsClaimed)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FilledButton(
                        onPressed: () async {
                          final bloc = _bloc(context);
                          await pointsKey.currentState?.addFireworkBomb(
                            Offset(
                              constraints.maxWidth / 2,
                              constraints.maxHeight / 2,
                            ),
                          );
                          if (bloc.isClosed) return;
                          bloc.add(IncreasePointsSAGGameBE());
                          setState(() {
                            arePointsClaimed = true;
                          });
                        },
                        child: Text("Claim points"),
                      ),
                    ),

                  PointsWidget(
                    key: pointsKey,
                    points: state.sagGame.pointsGained,
                  ),
                ],
              );
            },
          );
          // }
        },
      ),
    );
  }
}

class RotaryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    // Number of segments
    const int segments = 16;
    final segmentAngle = 2 * pi / segments;

    for (var i = 0; i < segments; i++) {
      final startAngle = i * segmentAngle;
      // Define the triangle path
      final path = Path();
      path.moveTo(center.dx, center.dy); // Start at center

      // First point of the triangle (on the circle)
      final x1 = center.dx + radius * cos(startAngle);
      final y1 = center.dy + radius * sin(startAngle);
      path.lineTo(x1, y1);

      // Second point of the triangle (on the circle)
      final x2 = center.dx + radius * cos(startAngle + segmentAngle);
      final y2 = center.dy + radius * sin(startAngle + segmentAngle);
      path.lineTo(x2, y2);

      // Close the path to complete the triangle
      path.close();

      // Create a radial gradient paint
      final Paint gradientPaint =
          Paint()
            ..shader = RadialGradient(
              colors: [
                i % 2 == 0
                    ? Colors.yellow.withValues(alpha: 0.5)
                    : Colors.deepPurpleAccent.withValues(alpha: 0.5),
                Colors.transparent,
              ],
              stops: const [0.0, 1.0],
              center: Alignment.center,
              radius: 0.25,
            ).createShader(Rect.fromCircle(center: center, radius: radius));

      // Draw the filled triangle with gradient
      canvas.drawPath(path, gradientPaint);

      // Draw the outline if needed
      // canvas.drawPath(path, blackPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
