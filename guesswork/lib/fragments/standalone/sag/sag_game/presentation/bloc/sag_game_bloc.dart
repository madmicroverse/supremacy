import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/constants/resources.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/core/domain/extension/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/add_coins_use_case.dart';
import 'package:guesswork/core/domain/use_case/upsert_user_sag_game_use_case.dart';
import 'package:guesswork/di/modules/router_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/use_case/create_sag_game_use_case.dart';

import '../../domain/use_case/get_sag_game_use_case.dart';
import 'sag_game_be.dart';
import 'sag_game_bsc.dart';

class SAGGameBloc extends Bloc<SAGGameBE, SAGGameBSC> {
  final IRouter _router;
  final GetSAGGameUseCase _getSAGGameUseCase;
  final UpsertUserSAGGameUseCase _upsertUserSAGGameUseCase;
  final AddCoinsStreamUseCase _addCoinsStreamUseCase;
  final CreateSAGGameUseCase _createSAGGameUseCase;

  AudioPlayer? gameCompletedBackgroundMusicPlayer;

  SAGGameBloc(
    this._router,
    this._getSAGGameUseCase,
    this._upsertUserSAGGameUseCase,
    this._addCoinsStreamUseCase,
    this._createSAGGameUseCase,
  ) : super(SAGGameBSC()) {
    on<PopSAGGameBE>(_popBlocEvent);
    on<InitSAGGameBE>(_initGameSetBlocEvent);
    on<InitSAGGameItemLoopBE>(_initSAGGameItemLoopBE);
    on<AddPointsSAGGameBE>(_addPointsSAGGameBE);
    on<InitAudioPlayersBE>(_initAudioPlayersBE);
  }

  FutureOr<void> _initGameSetBlocEvent(
    InitSAGGameBE event,
    Emitter<SAGGameBSC> emit,
  ) async {
    add(InitAudioPlayersBE());
    final result = await _getSAGGameUseCase(event.sagGameId);
    switch (result) {
      case Success():
        emit(state.withSAGGameBSC(result.data));
        add(InitSAGGameItemLoopBE(result.data));
      case Error():
        // final result = await _createSAGGameUseCase();
        throw UnimplementedError();
    }
  }

  FutureOr<void> _initAudioPlayersBE(
    InitAudioPlayersBE event,
    Emitter<SAGGameBSC> emit,
  ) {
    gameCompletedBackgroundMusicPlayer = AudioPlayer();
    gameCompletedBackgroundMusicPlayer?.setVolume(0.25);
    gameCompletedBackgroundMusicPlayer?.setReleaseMode(ReleaseMode.loop);
    gameCompletedBackgroundMusicPlayer?.setSource(
      AudioAsset.gameCompleteMusic.source,
    );
  }

  FutureOr<void> _initSAGGameItemLoopBE(
    InitSAGGameItemLoopBE event,
    Emitter<SAGGameBSC> emit,
  ) async {
    for (var sagGameItem in event.sagGame.sageGameItemList) {
      SAGGameItem? result = await _router.pushNamed<SAGGameItem>(
        sagGameItemRouteName,
        extra: sagGameItem.copyWith(setName: event.sagGame.title),
      );

      if (result.isNotNull) {
        final newSAGGame =
            state.sagGame!.withSAGGameItem(result!).withCompletedStatus;
        final upsertResult = await _upsertUserSAGGameUseCase(
          state.userSAGGameId,
          newSAGGame,
        );

        switch (upsertResult) {
          case Success():
            emit(
              state
                  .withSAGGameBSC(newSAGGame)
                  .withUserSAGGameId(upsertResult.data),
            );

            if (newSAGGame.isCompleted) {
              gameCompletedBackgroundMusicPlayer?.resume();
            }

          case Error():
            throw UnimplementedError();
        }
      } else {
        return _router.pop();
      }
    }
  }

  FutureOr<void> _popBlocEvent(PopSAGGameBE event, Emitter<SAGGameBSC> emit) {
    _router.pop();
  }

  FutureOr<void> _addPointsSAGGameBE(
    AddPointsSAGGameBE event,
    Emitter<SAGGameBSC> emit,
  ) async {
    _addCoinsStreamUseCase(state.sagGame.pointsGained);
  }
}
