import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/games.dart';

part 'games_favorite.freezed.dart';
part 'games_favorite.g.dart';

@freezed
abstract class GamesFavorite with _$GamesFavorite {
  const factory GamesFavorite({
    @JsonKey(includeToJson: false) String? id,
    required String gameId,
    required GameType gameType,
    @Default(false) bool isFavorite,
  }) = _GamesFavorite;

  factory GamesFavorite.fromJson(Map<String, dynamic> json) =>
      _$GamesFavoriteFromJson(json);
}

