import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/widgets/scratchable/foregrounds/letter_burst.dart';

import '../bloc/sag_game_item_bloc.dart';
import '../bloc/sag_game_item_bs.dart';

class ScratchForeground extends StatelessWidget {
  final SAGGameItemBS sagGameItemBS;
  final double width;
  final double height;

  const ScratchForeground({
    super.key,
    required this.sagGameItemBS,
    required this.width,
    required this.height,
  });

  SAGGameItemBloc _bloc(BuildContext context) =>
      context.read<SAGGameItemBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SAGGameItemBloc, SAGGameItemBS>(
      buildWhen:
          (state, nextState) => state.doesGamesItemBecameCompleted(nextState),
      builder: (context, state) {
        Widget foreground = LetterBurst(
          width: width,
          height: height,
          letter: '?',
          background: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.blueGrey,
          ),
          color: Colors.white,
        );

        if (state.isGameComplete) {
          foreground = foreground.animate().fadeOut(duration: 250.ms);
        }

        return foreground;
      },
    );
  }
}
