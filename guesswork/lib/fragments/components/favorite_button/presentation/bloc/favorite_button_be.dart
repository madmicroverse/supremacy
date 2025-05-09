import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class FavoriteButtonBE {}

class UpdateGameFavoritesBE extends FavoriteButtonBE {
  SAGGame sagGame;
  List<SAGGame> gamesFavoriteList;

  UpdateGameFavoritesBE(this.sagGame, this.gamesFavoriteList);
}

class InitSAGGameFavoriteBE extends FavoriteButtonBE {
  SAGGame sagGame;

  InitSAGGameFavoriteBE(this.sagGame);
}

class FavoriteGameBE extends FavoriteButtonBE {
  bool isFavorite;
  SAGGame sagGameFavorite;

  FavoriteGameBE(this.sagGameFavorite, this.isFavorite);
}
