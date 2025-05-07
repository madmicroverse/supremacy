import 'package:flutter/material.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game_item/presentation/view/scratchable.dart';

import '../bloc/sag_game_item_bs.dart';
import 'question.dart';
import 'scratch_foreground.dart';

/*
 * It requires that the state.content.gamesImage is ready
`*/
class ScratchSection extends StatelessWidget {
  final SAGGameItemBS sagGameItemBS;

  const ScratchSection({super.key, required this.sagGameItemBS});

  @override
  Widget build(BuildContext context) {
    final gamesImage = sagGameItemBS.gamesImage!;
    return AbsorbPointer(
      absorbing: sagGameItemBS.isGameItemComplete,
      child: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          double questionBarHeight = 40;
          Size imageSize = gamesImage.size;
          final adjConstraints = constraints.copyWith(
            maxHeight: constraints.maxHeight - questionBarHeight,
          );
          Size bestFitSize = adjConstraints
              .constrainSizeAndAttemptToPreserveAspectRatio(imageSize);

          if (!sagGameItemBS.isRevealedPathAvailable) {}

          return Card(
            margin: EdgeInsets.zero,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Wrap(
                children: [
                  SizedBox(
                    width: bestFitSize.width,
                    height: questionBarHeight,
                    child: Question(),
                  ),
                  SizedBox(
                    width: bestFitSize.width,
                    height: bestFitSize.height,
                    child: ScratchableWidget(
                      width: bestFitSize.width,
                      height: bestFitSize.height,
                      brushRadius: bestFitSize.width * 0.1037318312,
                      background: Image(
                        image: gamesImage.imageProvider,
                        fit: BoxFit.fitWidth,
                      ),
                      foreground: ScratchForeground(
                        sagGameItemBS: sagGameItemBS,
                        width: bestFitSize.width,
                        height: bestFitSize.height,
                      ),
                      sagGameItemBS: sagGameItemBS,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
