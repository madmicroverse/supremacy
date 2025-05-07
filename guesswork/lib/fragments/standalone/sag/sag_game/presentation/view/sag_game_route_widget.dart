import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/extension/sag_game.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/widgets/play_progress_button.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/presentation/view/points_widget.dart';

import '../bloc/sag_game_be.dart';
import '../bloc/sag_game_bloc.dart';
import '../bloc/sag_game_bsc.dart';

extension ContextBloc on BuildContext {
  SAGGameBloc get bloc => read<SAGGameBloc>();

  addEvent(SAGGameBE coinsBE) => bloc.add(coinsBE);
}

class SAGGameRouteWidget extends StatelessWidget {
  final PreferredSizeWidget appBarWidget;
  final blowPopDuration = 3000.ms;
  final delayedContinueDuration = 6000.ms;
  final autoStartDuration = 60000.ms;

  SAGGameRouteWidget({super.key, required this.appBarWidget});

  final GlobalKey<PointsWidgetState> pointsKey = GlobalKey<PointsWidgetState>();

  Duration claimDuration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget,
      body: BlocBuilder<SAGGameBloc, SAGGameBSC>(
        builder: (context, state) {
          // if (!state.isSAGGameCompleted) {
          //   return Container();
          // }

          return LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // GameSetBlocAppBar(),
                  CustomPaint(
                        painter: RotaryPainter(
                          context.colorScheme.primary,
                          context.colorScheme.surfaceContainerHigh,
                        ),
                        size: Size.infinite,
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .scaleXY(begin: 4, end: 4)
                      .rotate(
                        duration: Duration(minutes: 100),
                        begin: 0,
                        end: 20 * pi,
                      ),

                  if (state.isSAGGameClaimed)
                    Align(
                      alignment: Alignment.center,
                      child: PlayProgressButton(
                        duration: delayedContinueDuration,
                        onPressed: () => context.addEvent(CompleteSAGGameBE()),
                        child: Text("MORE"),
                      ),
                    ).animate().fadeIn(duration: 1500.ms, begin: 0),

                  if (state.isSAGGameAvailable &&
                      !state.isGameItemLoopInitialized)
                    Align(
                      alignment: Alignment.center,
                      child: PlayProgressButton(
                        duration: autoStartDuration,
                        onPressed:
                            () => context.addEvent(InitSAGGameItemLoopBE()),
                        child: Text("START"),
                      ),
                    ),

                  if (state.isSAGGameCompleted && !state.isClaimingPoints)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FilledButton(
                        onPressed: () async {
                          context.addEvent(AddPointsSAGGameBE(blowPopDuration));
                          await pointsKey.currentState?.addFireworkBomb(
                            context,
                            Offset(
                              constraints.maxWidth / 2,
                              constraints.maxHeight / 2,
                            ),
                          );
                        },
                        child: Text("Claim points"),
                      ),
                    ),

                  if (state.isSAGGameCompleted)
                    PointsWidget(
                      key: pointsKey,
                      points: state.sagGame.pointsGained,
                      duration: blowPopDuration,
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
  final Color colorAlpha;
  final Color colorBeta;

  RotaryPainter(this.colorAlpha, this.colorBeta);

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
              colors: [i % 2 == 0 ? colorAlpha : colorBeta, Colors.transparent],
              stops: const [0.0, 1.0],
              center: Alignment.center,
              radius: 0.3,
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
