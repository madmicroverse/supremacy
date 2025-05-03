import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

part 'sag_game_bsc.freezed.dart';

@freezed
abstract class SAGGameBSC with _$SAGGameBSC {
  const factory SAGGameBSC({
    @Default(true) bool isLoading,
    SAGGame? gameSet,
    @Default([]) List<SAGGameItemAnswer> guessGameAnswerList,
    @Default(false) bool isGameSetCompleted,
    @Default(3240) int userPoints,
    @Default(0) int totalPoints,
  }) = _SAGGameBSC;
}

extension SAGGameBSCStateUtils on SAGGameBSC {
  bool isLoadingCompleted(SAGGameBSC nextState) =>
      isLoading && !nextState.isLoading;

  bool userPointsUpdated(SAGGameBSC nextState) =>
      userPoints != nextState.userPoints;
}
