import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/image/games_image.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/sag_game.dart';

part 'sag_game_item_bs.freezed.dart';

@freezed
abstract class SAGGameItemBS with _$SAGGameItemBS {
  const factory SAGGameItemBS({
    SAGGameItem? sagGameItem,
    GamesImage? gamesImage,
    GamesSettings? gamesSettings,
    Path? revealedPath,
    @Default(1) double concealedRatio,
  }) = _SAGGameItemBS;
}

extension SAGGameItemBSCMutations on SAGGameItemBS {
  SAGGameItemBS withSagGameItem(SAGGameItem sagGameItem) =>
      copyWith(sagGameItem: sagGameItem);

  SAGGameItemBS withGamesImage(GamesImage gamesImage) =>
      copyWith(gamesImage: gamesImage);

  SAGGameItemBS withSAGGameItemAnswer(SAGGameItemAnswer sagGameItemAnswer) =>
      copyWith(sagGameItem: sagGameItem?.copyWith(answer: sagGameItemAnswer));

  SAGGameItemBS withGamesSettings(GamesSettings gamesSettings) =>
      copyWith(gamesSettings: gamesSettings);

  SAGGameItemBS withRevealedPath(Path revealedPath) =>
      copyWith(revealedPath: revealedPath);

  SAGGameItemBS withConcealedRatio(double concealedRatio) =>
      copyWith(concealedRatio: concealedRatio);
}

extension SAGGameItemBSCQueries on SAGGameItemBS {
  bool doesGamesImageBecameAvailable(SAGGameItemBS nextState) =>
      gamesImage != nextState.gamesImage;

  bool doesGamesSettingsBecameAvailable(SAGGameItemBS nextState) =>
      gamesSettings != nextState.gamesSettings;

  bool doesGamesItemBecameCompleted(SAGGameItemBS nextState) =>
      sagGameItem?.answer != nextState.sagGameItem?.answer;

  bool get isGamesImageAvailable => gamesImage != null;

  bool get isRevealedPathAvailable => revealedPath != null;

  bool get isGameItemComplete => sagGameItem?.answer != null;

  bool get isGameIncomplete => !isGameItemComplete;

  bool get isCorrectAnswer => sagGameItem.isCorrectAnswer;

  bool isSelectedOption(Option option) =>
      sagGameItem?.answer?.answerOptionId == option.id;

  bool isCorrectOption(Option option) =>
      sagGameItem?.answerOptionId == option.id;

  bool doesRevealedRatioChange(SAGGameItemBS nextState) =>
      concealedRatio != nextState.concealedRatio;
}
