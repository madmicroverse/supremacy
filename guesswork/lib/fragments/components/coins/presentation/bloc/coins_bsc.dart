import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';

part 'coins_bsc.freezed.dart';

@freezed
abstract class CoinsBSC with _$CoinsBSC {
  const factory CoinsBSC({
    GamesSettings? gamesSettings,
    int? amount,
    CoinsViewError? coinsViewError,
  }) = _CoinsBSC;
}

extension CoinsBSCMutations on CoinsBSC {
  CoinsBSC withAmount(int amount) => copyWith(amount: amount);

  CoinsBSC withGamesSettings(GamesSettings gamesSettings) =>
      copyWith(gamesSettings: gamesSettings);
}

extension CoinsBSCQueries on CoinsBSC {
  bool get isLoadingAmount => amount == null;

  bool get isSoundEnabled => gamesSettings.isSoundEnabled;

  bool get isVisible => coinsViewError.isNull;
}

sealed class CoinsViewError extends BaseError {}

class CoinsViewDataAccessError extends CoinsViewError {}
