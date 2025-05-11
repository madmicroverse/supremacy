import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
part 'sag_game_bsc.freezed.dart';

extension SAGGameItemList on List<SAGGameItem> {
  SAGGameItem nextTo(SAGGameItem? currentSAGGameItem) {
    final index = indexWhere((sagGameItem) {
      final condition = sagGameItem.id == currentSAGGameItem?.id;
      return condition;
    });
    return this[min(index + 1, length - 1)];
  }
}

@freezed
abstract class SAGGameBSC with _$SAGGameBSC {
  const factory SAGGameBSC({
    SAGGame? sagGame,
    String? userSAGGameId,
    @Default(false) isGameItemLoopInitialized,
    @Default(false) isClaimingPoints,
    GamesSettings? gamesSettings,
    SAGGameViewError? sagGameViewError,
    @Default(false) bool isLoading,
  }) = _SAGGameBSC;
}

extension SAGGameBSCStateMutations on SAGGameBSC {
  SAGGameBSC withSAGGameBSC(SAGGame sagGame) => copyWith(sagGame: sagGame);

  SAGGameBSC withUserSAGGameId(String userSAGGameId) =>
      copyWith(userSAGGameId: userSAGGameId);

  SAGGameBSC withGamesSettings(GamesSettings gamesSettings) =>
      copyWith(gamesSettings: gamesSettings);

  SAGGameBSC get claimingPoints => copyWith(isClaimingPoints: true);

  SAGGameBSC get initializedGameItemLoop =>
      copyWith(isGameItemLoopInitialized: true);

  SAGGameBSC withError(SAGGameViewError sagGameViewError) =>
      copyWith(sagGameViewError: sagGameViewError);

  SAGGameBSC get withoutError => copyWith(sagGameViewError: null);

  SAGGameBSC get idleState => copyWith(isLoading: false);

  SAGGameBSC get loadingState => copyWith(isLoading: true);
}

extension SAGGameBSCStateQueries on SAGGameBSC {
  bool doesSAGGameBecameAvailable(SAGGameBSC nextState) =>
      sagGame != nextState.sagGame && nextState.sagGame != null;

  bool doesGamesSettingsBecameAvailable(SAGGameBSC nextState) =>
      gamesSettings != nextState.gamesSettings;

  bool get isMusicEnabled => gamesSettings.isMusicEnabled;

  bool get isSoundEnabled => gamesSettings.isSoundEnabled;

  bool get isSAGGameAvailable => sagGame != null;

  bool get isSAGGameCompleted => sagGame?.isCompleted ?? false;

  bool get isSAGGameClaimed => sagGame?.isClaimed ?? false;

  SAGGameItem nextSagGameItem({SAGGameItem? currentSAGGameItem}) =>
      sagGame!.sageGameItemList.nextTo(currentSAGGameItem);

  bool isNewSAGGameViewError(SAGGameBSC nextState) =>
      sagGameViewError != nextState.sagGameViewError &&
      nextState.sagGameViewError != null;
}

sealed class SAGGameViewError extends BaseError {}

class SAGGameViewSystemError extends SAGGameViewError {}

class SAGGameViewConnectionError extends SAGGameViewError {
  SAGGame sagGame;
  SAGGameItem sagGameItem;

  SAGGameViewConnectionError(this.sagGame, this.sagGameItem);
}
