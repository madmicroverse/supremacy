import 'package:guesswork/core/domain/entity/games.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';

sealed class FavoriteButtonBE {}

class UpdateGameFavoritesBE extends FavoriteButtonBE {
  String gameId;
  GameType gameType;
  List<GamesFavorite> gamesFavoriteList;

  UpdateGameFavoritesBE(this.gameId, this.gameType, this.gamesFavoriteList);
}

class InitSAGGameFavoriteBE extends FavoriteButtonBE {
  String gameId;

  InitSAGGameFavoriteBE(this.gameId);
}

class FavoriteGameBE extends FavoriteButtonBE {
  String gameId;
  GameType gameType;
  GamesFavorite? gamesFavorite;

  FavoriteGameBE(this.gameId, this.gameType, this.gamesFavorite);
}
