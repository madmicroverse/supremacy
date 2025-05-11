import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';

part 'favorite_button_bs.freezed.dart';

@freezed
abstract class FavoriteButtonBS with _$FavoriteButtonBS {
  const factory FavoriteButtonBS({
    bool? isFavorite,
    Function()? onPressed,
    FavoriteButtonViewError? favoriteButtonViewError,
  }) = _FavoriteButtonBS;
}

extension FavoriteButtonBSMutations on FavoriteButtonBS {
  FavoriteButtonBS withIsFavorite(bool isFavorite) =>
      copyWith(isFavorite: isFavorite);

  FavoriteButtonBS withOnPressed(Function() onPressed) =>
      copyWith(onPressed: onPressed);

  FavoriteButtonBS withError(FavoriteButtonViewError favoriteButtonViewError) =>
      copyWith(favoriteButtonViewError: favoriteButtonViewError);

  FavoriteButtonBS get withoutError => copyWith(favoriteButtonViewError: null);
}

extension FavoriteButtonBSQueries on FavoriteButtonBS {
  bool get isLoadingFavorite => isFavorite.isNotNull;

  bool get isFavoriteSafe => isFavorite ?? false;

  bool get isVisible => favoriteButtonViewError.isNull;
}

sealed class FavoriteButtonViewError extends BaseError {}

class FavoriteButtonViewDataAccessError extends FavoriteButtonViewError {}
