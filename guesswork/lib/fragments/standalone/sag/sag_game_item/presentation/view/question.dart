import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';

import '../bloc/sag_game_item_bloc.dart';
import '../bloc/sag_game_item_bs.dart';

class Question extends StatelessWidget {
  const Question({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SAGGameItemBloc, SAGGameItemBS>(
      buildWhen:
          (state, nextState) =>
              state.doesGamesItemBecameCompleted(nextState) ||
              state.doesRevealedRatioChange(nextState),
      builder: (context, state) {
        final guessGame = state.sagGameItem!;
        return Stack(
          children: [
            FAProgressBar(
              size: 40,
              borderRadius: BorderRadius.zero,
              backgroundColor: context.colorScheme.surfaceContainer,
              currentValue: guessGame.points * state.concealedRatio,
              maxValue: guessGame.points.toDouble(),
              displayText: '',
              formatValue: (double value, int? fixed) {
                return '';
              },
              displayTextStyle: TextStyle(fontSize: 20),
              progressColor:
                  state.isGameItemComplete
                      ? state.isCorrectAnswer
                          ? context.gamesColors.correct
                          : context.gamesColors.incorrect
                      : context.gamesColors.correct,
            ),
            SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  state.sagGameItem!.question,
                  style: TextStyle(
                    fontSize: 25,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
