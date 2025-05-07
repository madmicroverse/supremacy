import 'package:guesswork/core/domain/entity/account/games_user.dart';

sealed class CoinsBE {}

class InitCoinsBE extends CoinsBE {}

class UpdateCoinsAmountBE extends CoinsBE {
  final int amount;

  UpdateCoinsAmountBE(this.amount);
}

class GamesSettingsUpdateBE extends CoinsBE {
  final GamesSettings gamesSettings;

  GamesSettingsUpdateBE(this.gamesSettings);

}
