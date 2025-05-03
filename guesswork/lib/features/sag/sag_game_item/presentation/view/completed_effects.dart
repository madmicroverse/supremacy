import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sag_game_item_bloc.dart';
import '../bloc/sag_game_item_bs.dart';

class CompleteEffects extends StatefulWidget {
  final SAGGameItemBS sagGameItemBS;

  const CompleteEffects({super.key, required this.sagGameItemBS});

  @override
  State<CompleteEffects> createState() => _CompleteEffectsState();
}

class _CompleteEffectsState extends State<CompleteEffects> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: 800.ms);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SAGGameItemBloc, SAGGameItemBS>(
      listener: (BuildContext context, SAGGameItemBS state) {
        if (state.isGameComplete) {
          if (state.isCorrectAnswer) {
            _confettiController.play();
            // if (sagGameItemBS..gamesSettings?.sound ?? false) {
            //   Future.delayed(0.ms, () => partyPopperPlayer.resume());
            //   Future.delayed(100.ms, () => audienceCheeringPlayer.resume());
            // }
          } else {
            // if (widget.gamesSettings?.sound ?? false) {
            //   wrongAnswerPlayer.resume();
            // }
          }
        }
      },
      builder: (context, state) {
        if (state.isGameComplete) {
          if (state.isCorrectAnswer) {
            final numberOfParticles = max(
              1,
              (20 * state.concealedRatio).ceil(),
            );

            return Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 1.0,
                numberOfParticles: numberOfParticles,
              ),
            );
          } else {
            return Align(
              alignment: Alignment.center,
              child: Text(
                    "X",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )
                  .animate(
                    // onPlay: (controller) => controller.repeat()
                  )
                  .effect(duration: 2000.ms)
                  .shake(curve: Curves.easeInOutCubic, hz: 3.5)
                  .scaleXY(begin: 0, end: 100)
                  .fadeOut(begin: 1, duration: 2000.ms),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
}
