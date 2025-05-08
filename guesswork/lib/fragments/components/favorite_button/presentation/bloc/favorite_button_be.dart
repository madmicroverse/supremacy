import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class FavoriteButtonBE {}

class InitSAGGameFavoriteBE extends FavoriteButtonBE {
  SAGGame sagGame;

  InitSAGGameFavoriteBE(this.sagGame);
}

class SelectSAGGameFavoriteBE extends FavoriteButtonBE {
  SAGGame sagGame;

  SelectSAGGameFavoriteBE(this.sagGame);
}
