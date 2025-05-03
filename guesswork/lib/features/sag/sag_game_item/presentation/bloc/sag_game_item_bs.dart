import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/image/games_image.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';

part 'sag_game_item_bs.freezed.dart';

@freezed
abstract class SAGGameItemBS with _$SAGGameItemBS {
  const factory SAGGameItemBS({
    SAGGameItem? sagGameItem,
    GamesImage? gamesImage,
    GamesSettings? gamesSettings,
    Path? revealedPath,
    @Default(0) double revealedRatio,
    SAGGameItemAnswer? sagGameItemAnswer,
  }) = _SAGGameItemBS;
}

extension SAGGameItemBSCUtils on SAGGameItemBS {
  SAGGameItemBS withSagGameItem(SAGGameItem sagGameItem) =>
      copyWith(sagGameItem: sagGameItem);

  SAGGameItemBS withGamesImage(GamesImage gamesImage) =>
      copyWith(gamesImage: gamesImage);

  SAGGameItemBS withSAGGameItemAnswer(SAGGameItemAnswer sagGameItemAnswer) =>
      copyWith(sagGameItemAnswer: sagGameItemAnswer);

  SAGGameItemBS withGamesSettings(GamesSettings gamesSettings) =>
      copyWith(gamesSettings: gamesSettings);

  SAGGameItemBS withRevealedPath(Path revealedPath) =>
      copyWith(revealedPath: revealedPath);

  // SAGGameItemBS withConcealedPoints(Set<Offset> concealedPoints) =>
  //     copyWith(concealedPoints: concealedPoints);
  //
  // SAGGameItemBS withPathPoints(Set<Offset> pathPoints) =>
  //     copyWith(pathPoints: pathPoints);

  bool doesGamesImageBecameAvailable(SAGGameItemBS nextState) =>
      gamesImage != nextState.gamesImage;

  bool doesGamesSettingsBecameAvailable(SAGGameItemBS nextState) =>
      gamesSettings != nextState.gamesSettings;

  bool doesGamesItemBecameCompleted(SAGGameItemBS nextState) =>
      sagGameItemAnswer?.isCompleted !=
      nextState.sagGameItemAnswer?.isCompleted;

  bool get isGamesImageAvailable => gamesImage != null;

  bool get isRevealedPathAvailable => revealedPath != null;

  bool get isGameComplete => sagGameItemAnswer?.isCompleted ?? false;

  bool get isCorrectAnswer => sagGameItemAnswer?.isCorrect ?? false;

  bool isSelectedOption(Option option) =>
      sagGameItemAnswer?.answerOptionId == option.id;

  bool isCorrectOption(Option option) {
    return sagGameItem?.answer == option.id;
  }

  double get concealedRatio => 1 - revealedRatio;

  bool doesRevealedRatioChange(SAGGameItemBS nextState) =>
      revealedRatio != nextState.revealedRatio;
}
