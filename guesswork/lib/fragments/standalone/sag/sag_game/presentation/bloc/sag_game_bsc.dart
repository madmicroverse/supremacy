import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

part 'sag_game_bsc.freezed.dart';

@freezed
abstract class SAGGameBSC with _$SAGGameBSC {
  const factory SAGGameBSC({
    SAGGame? sagGame,
    String? userSAGGameId,
    @Default(false) isGameItemLoopInitialized,
    @Default(false) isClaimingPoints,
    GamesSettings? gamesSettings,
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
}
