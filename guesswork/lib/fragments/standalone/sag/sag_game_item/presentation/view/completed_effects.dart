import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/extension/basic.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game_item/presentation/view/bloc_utils.dart';

import '../bloc/sag_game_item_bloc.dart';
import '../bloc/sag_game_item_bs.dart';

class CompleteEffects extends StatelessWidget {
  const CompleteEffects({super.key});

  // late ConfettiController _confettiController;

  // @override
  bool _reconstructionCondition(SAGGameItemBS state, SAGGameItemBS nextState) =>
      state.doesGamesItemBecameCompleted(nextState);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SAGGameItemBloc, SAGGameItemBS>(
      buildWhen: _reconstructionCondition,
      builder: (context, state) {
        if (state.isGameIncomplete) {
          return Container();
        } else {
          if (state.isCorrectAnswer) {
            final numberOfParticles = state.revealedRatio.inverse.remapped(1, 20);
            return Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: context.confettiController,
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
        }
      },
    );
  }
}
