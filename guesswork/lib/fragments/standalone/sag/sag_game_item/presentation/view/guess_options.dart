import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/basic.dart';
import 'package:guesswork/core/presentation/extension/animation_utils.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game_item/presentation/view/bloc_utils.dart';

import '../bloc/sag_game_item_be.dart';
import '../bloc/sag_game_item_bloc.dart';
import '../bloc/sag_game_item_bs.dart';

class GuessOptions extends StatelessWidget {
  final int columns;
  final Duration animDuration;

  const GuessOptions({
    super.key,
    this.columns = 2,
    this.animDuration = const Duration(milliseconds: 1500),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SAGGameItemBloc, SAGGameItemBS>(
      buildWhen:
          (state, nextState) => state.doesGamesItemBecameCompleted(nextState),
      builder: (context, state) {
        return AnimatedContainer(
          height: 150.0,
          duration: Duration(milliseconds: 500),
          child: LayoutBuilder(
            builder: (context, BoxConstraints constraints) {
              final guessGame = state.sagGameItem!;
              final isGameComplete = state.isGameItemComplete;
              double completedRatio = 0.25;
              int rows =
                  guessGame.optionList.length.rows(columns) +
                  isGameComplete.intValue;
              final width = constraints.maxWidth / columns;
              final height = constraints.maxHeight / rows;
              return Wrap(
                spacing: 0.0, // gap between adjacent children horizontally
                runSpacing: 0.0, // gap between lines
                children: <Widget>[
                  ...guessGame.optionList.map((option) {
                    return AnimatedContainer(
                      width: width,
                      height:
                          height *
                          max(1 - completedRatio, isGameComplete.invIntValue),
                      duration: animDuration,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: double.maxFinite,
                            child: FilledButton(
                              onPressed:
                                  isGameComplete
                                      ? null
                                      : () {
                                        context.addEvent(
                                          GuessSAGGameItemBE(option),
                                        );
                                      },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  _getButtonColor(
                                    state,
                                    option,
                                    isGameComplete,
                                  ),
                                ),
                              ),
                              child: Text(
                                option.text,
                                style: TextStyle(
                                  color:
                                      isGameComplete
                                          ? Colors.black45
                                          : Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ).animate().scaleXY(
                              end: isGameComplete ? 0.7 : 1.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  if (isGameComplete)
                    SizedBox(
                      height: height * (1 + (rows - 1) * completedRatio),
                      child:
                          Center(
                            child: FutureBuilder(
                              future: Future.delayed(animDuration, () => true),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                }
                                return FilledButton(
                                  onPressed: () {
                                    if (snapshot.hasData) {
                                      context.addEvent(ContinueSAGGameItemBE());
                                    }
                                  },
                                  child: Text("Continuar"),
                                );
                              },
                            ),
                          ).happyBounce,
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Color _getButtonColor(SAGGameItemBS state, Option option, bool isCompleted) {
    if (state.isGameItemComplete &&
        (state.isSelectedOption(option) || state.isCorrectOption(option))) {
      if (state.isCorrectOption(option)) {
        return Colors.green.withValues(alpha: isCompleted ? 0.5 : 1);
      } else {
        return Colors.red.withValues(alpha: isCompleted ? 0.5 : 1);
      }
    }

    return Colors.orange.withValues(alpha: isCompleted ? 0.5 : 1);
  }
}
