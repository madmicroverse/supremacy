import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

part 'sag_game_bsc.freezed.dart';

@freezed
abstract class SAGGameBSC with _$SAGGameBSC {
  const factory SAGGameBSC({
    SAGGame? sagGame,
    String? userSAGGameId,
    @Default([]) List<SAGGameItemAnswer> guessGameAnswerList,
  }) = _SAGGameBSC;
}

extension SAGGameBSCStateMutations on SAGGameBSC {
  SAGGameBSC withSAGGameBSC(SAGGame sagGame) => copyWith(sagGame: sagGame);

  SAGGameBSC withUserSAGGameId(String userSAGGameId) =>
      copyWith(userSAGGameId: userSAGGameId);
}

extension SAGGameBSCStateQueries on SAGGameBSC {
  bool doesSAGGameBecameAvailable(SAGGameBSC nextState) =>
      sagGame != nextState.sagGame && nextState.sagGame != null;

  bool get isSAGGameAvailable => sagGame != null;

  bool get isSAGGameCompleted => sagGame?.isCompleted ?? false;
}
