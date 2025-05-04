import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

part 'sag_game_bsc.freezed.dart';

@freezed
abstract class SAGGameBSC with _$SAGGameBSC {
  const factory SAGGameBSC({
    SAGGame? gameSet,
    @Default([]) List<SAGGameItemAnswer> guessGameAnswerList,
    @Default(false) bool isGameSetCompleted,
    @Default(3240) int userPoints,
    @Default(0) int totalPoints,
  }) = _SAGGameBSC;
}

extension SAGGameBSCStateMutations on SAGGameBSC {
  SAGGameBSC withSAGGameBSC(SAGGame gameSet) => copyWith(gameSet: gameSet);
}

extension SAGGameBSCStateQueries on SAGGameBSC {
  bool doesSAGGameBecameAvailable(SAGGameBSC nextState) =>
      gameSet != nextState.gameSet && nextState.gameSet != null;

  bool get isSAGGameAvailable => gameSet != null;

  bool userPointsUpdated(SAGGameBSC nextState) =>
      userPoints != nextState.userPoints;
}
