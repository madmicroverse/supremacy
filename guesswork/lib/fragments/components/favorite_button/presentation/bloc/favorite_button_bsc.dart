import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_button_bsc.freezed.dart';

@freezed
abstract class FavoriteButtonBS with _$FavoriteButtonBS {
  const factory FavoriteButtonBS({bool? isFavorite, Function()? onPressed}) =
      _FavoriteButtonBS;
}

extension FavoriteButtonBSMutations on FavoriteButtonBS {
  FavoriteButtonBS withIsFavorite(bool isFavorite) =>
      copyWith(isFavorite: isFavorite);

  FavoriteButtonBS withOnPressed(Function() onPressed) =>
      copyWith(onPressed: onPressed);
}

extension FavoriteButtonBSQueries on FavoriteButtonBS {
  bool get isLoadingFavorite => isFavorite == null;

  bool get isFavoriteSafe => isFavorite ?? false;
}
