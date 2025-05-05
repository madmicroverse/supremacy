import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sag_game_item_bloc.dart';
import '../bloc/sag_game_item_bs.dart';

class Question extends StatelessWidget {
  final SAGGameItemBS sagGameItemBS;

  const Question({super.key, required this.sagGameItemBS});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SAGGameItemBloc, SAGGameItemBS>(
      builder: (context, state) {
        final guessGame = sagGameItemBS.sagGameItem!;
        return Stack(
          children: [
            FAProgressBar(
              size: 40,
              borderRadius: BorderRadius.zero,
              backgroundColor: Colors.black12,
              currentValue: guessGame.points * sagGameItemBS.concealedRatio,
              maxValue: guessGame.points.toDouble(),
              displayText: '',
              formatValue: (double value, int? fixed) {
                return '';
              },
              displayTextStyle: TextStyle(fontSize: 20),
              progressColor:
                  sagGameItemBS.isGameItemComplete
                      ? sagGameItemBS.isCorrectAnswer
                          ? Colors.green
                          : Colors.black54
                      : Colors.green,
            ),
            SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  sagGameItemBS.sagGameItem!.question,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
