import 'package:freezed_annotation/freezed_annotation.dart';

part 'sag_game.freezed.dart';
part 'sag_game.g.dart';

@freezed
abstract class Option with _$Option {
  const factory Option({required int id, required String text}) = _Option;

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}

@freezed
abstract class SAGGameItem with _$SAGGameItem {
  const factory SAGGameItem({
    required String id,
    required int version,
    required int points,
    required String guessImageUrl,
    required String question,
    required List<Option> optionList,
    required SAGGameItemAnswer? answer,
    required int answerOptionId,
    @JsonKey(includeToJson: false) String? sagGameTitle,
  }) = _SAGGameItem;

  factory SAGGameItem.fromJson(Map<String, dynamic> json) =>
      _$SAGGameItemFromJson(json);
}

@freezed
abstract class PathPoint with _$PathPoint {
  const factory PathPoint({required double x, required double y}) = _PathPoint;

  factory PathPoint.fromJson(Map<String, dynamic> json) =>
      _$PathPointFromJson(json);
}

@freezed
abstract class SAGGameItemAnswer with _$SAGGameItemAnswer {
  const factory SAGGameItemAnswer({
    required int answerOptionId,
    @Default(0.0) double concealedRatio,
    @Default([]) List<PathPoint> pathPoints,
  }) = _SAGGameItemAnswer;

  factory SAGGameItemAnswer.fromJson(Map<String, dynamic> json) =>
      _$SAGGameItemAnswerFromJson(json);
}

@freezed
abstract class SAGGamePreview with _$SAGGamePreview {
  const factory SAGGamePreview({
    @JsonKey(includeToJson: false) required String id,
    required String title,
    required String previewImage,
  }) = _SAGGamePreview;

  factory SAGGamePreview.fromJson(Map<String, dynamic> json) =>
      _$SAGGamePreviewFromJson(json);
}

@freezed
abstract class SAGGame with _$SAGGame {
  const factory SAGGame({
    @JsonKey(includeToJson: false) required String id,
    @Default(false) bool isClaimed,
    @Default(false) bool isCompleted,
    required String title,
    required String previewImage,
    required String description,
    required List<SAGGameItem> sageGameItemList,
  }) = _SAGGame;

  factory SAGGame.fromJson(Map<String, dynamic> json) =>
      _$SAGGameFromJson(json);
}
