import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';

extension GamesFavoriteMutations on GamesFavorite {
  GamesFavorite get toggle => copyWith(isFavorite: !isFavorite);
}
