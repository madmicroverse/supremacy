import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/constants/resources.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/audio_player.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/core/domain/extension/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/add_coins_use_case.dart';
import 'package:guesswork/di/modules/router_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/use_case/get_sag_game_use_case.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/use_case/upsert_user_sag_game_use_case.dart';
import 'package:guesswork/fragments/standalone/settings/domain/use_case/get_game_settings_stream_use_case.dart';

import 'sag_game_be.dart';
import 'sag_game_bsc.dart';

class SAGGameBloc extends Bloc<SAGGameBE, SAGGameBSC> {
  final IRouter _router;
  final GetSAGGameUseCase _getSAGGameUseCase;
  final UpsertUserSAGGameUseCase _upsertUserSAGGameUseCase;
  final AddCoinsStreamUseCase _addCoinsStreamUseCase;
  final GetGamesSettingsStreamUseCase _getGamesSettingsUseCase;

  StreamSubscription<GamesSettings>? _gamesSettingsSubscription;

  AudioPlayer? gameCompletedBGAudioPlayer;
  AudioPlayer? inflatingPlayer;
  AudioPlayer? partyPopperPlayer;

  SAGGameBloc(
    this._router,
    this._getSAGGameUseCase,
    this._upsertUserSAGGameUseCase,
    this._addCoinsStreamUseCase,
    this._getGamesSettingsUseCase,
  ) : super(SAGGameBSC()) {
    on<PopSAGGameBE>(_popBlocEvent);
    on<InitSAGGameBE>(_initGameSetBlocEvent);
    on<LaunchSAGGameItemBE>(_launchSAGGameItemBE);
    on<RetryUpsertSAGGameBE>(_retryUpsertSAGGameBE);
    on<GamesSettingsUpdateBE>(_gamesSettingsUpdateBE);
    on<AddPointsSAGGameBE>(_addPointsSAGGameBE);
    on<InitAudioPlayersBE>(_initAudioPlayersBE);
    on<CompleteSAGGameBE>(_completeSAGGameBE);
  }

  FutureOr<void> _initGameSettingsBE() async {
    final result = await _getGamesSettingsUseCase();
    switch (result) {
      case Success():
        _gamesSettingsSubscription = result.data.listen((gamesSettings) {
          add(GamesSettingsUpdateBE(gamesSettings));
        });
      case Error():
        switch (result.error) {
          default:
          // return emit(state.errorState(result.error.toString()));
        }
    }
  }

  FutureOr<void> _initGameSetBlocEvent(
    InitSAGGameBE event,
    Emitter<SAGGameBSC> emit,
  ) async {
    _initGameSettingsBE();
    add(InitAudioPlayersBE());
    emit(state.loadingState);
    final result = await _getSAGGameUseCase(event.sagGameId);
    emit(state.idleState);
    switch (result) {
      case Success():
        emit(state.withSAGGameBSC(result.data));
        add(LaunchSAGGameItemBE(state.nextSagGameItem()));
      case Error():
        // final result = await _createSAGGameUseCase();
        throw UnimplementedError();
    }
  }

  FutureOr<void> _initAudioPlayersBE(
    InitAudioPlayersBE event,
    Emitter<SAGGameBSC> emit,
  ) {
    gameCompletedBGAudioPlayer = AudioPlayer();
    gameCompletedBGAudioPlayer?.setVolume(0.25);
    gameCompletedBGAudioPlayer?.setReleaseMode(ReleaseMode.loop);
    gameCompletedBGAudioPlayer?.setSource(AudioAsset.gameCompleteMusic.source);

    inflatingPlayer = AudioPlayer();
    inflatingPlayer?.setVolume(0.25);
    inflatingPlayer?.setReleaseMode(ReleaseMode.release);
    inflatingPlayer?.setSource(AudioAsset.inflating.source);

    partyPopperPlayer = AudioPlayer();
    partyPopperPlayer?.setVolume(0.25);
    partyPopperPlayer?.setReleaseMode(ReleaseMode.release);
    partyPopperPlayer?.setSource(AudioAsset.partyPopper.source);
  }

  FutureOr<void> _gamesSettingsUpdateBE(GamesSettingsUpdateBE event, emit) {
    emit(state.withGamesSettings(event.gamesSettings));
    if (event.gamesSettings.isMusicEnabled &&
        !gameCompletedBGAudioPlayer.isPlaying &&
        !state.isClaimingPoints &&
        state.isSAGGameCompleted) {
      gameCompletedBGAudioPlayer?.resume();
    } else if (!event.gamesSettings.isMusicEnabled &&
        gameCompletedBGAudioPlayer.isPlaying) {
      gameCompletedBGAudioPlayer?.stop();
    }
  }

  FutureOr<void> _launchSAGGameItemBE(
    LaunchSAGGameItemBE event,
    Emitter<SAGGameBSC> emit,
  ) async {
    final sagGame = state.sagGame!;
    final sagGameItem = event.sagGameItem;

    SAGGameItem? result = await _router.pushNamed<SAGGameItem>(
      sagGameItemRouteName,
      extra: sagGameItem.withSAGGameTitle(sagGame.title),
    );

    if (result.isNotNull) {
      final newSAGGame = sagGame.withSAGGameItem(result!).completed;
      emit(state.loadingState);
      final upsertResult = await _upsertUserSAGGameUseCase(
        state.userSAGGameId,
        newSAGGame,
      );
      _handleUpsertSAGGameResult(upsertResult, newSAGGame, sagGameItem, emit);
    } else {
      return _router.pop();
    }
  }

  FutureOr<void> _retryUpsertSAGGameBE(
    RetryUpsertSAGGameBE event,
    Emitter<SAGGameBSC> emit,
  ) async {
    emit(state.loadingState);
    final upsertResult = await _upsertUserSAGGameUseCase(
      state.userSAGGameId,
      event.sagGame,
    );
    _handleUpsertSAGGameResult(
      upsertResult,
      event.sagGame,
      event.sagGameItem,
      emit,
    );
  }

  _handleUpsertSAGGameResult(
    Result<String, UpsertUserSAGGameUseCaseError> upsertResult,
    SAGGame sagGame,
    SAGGameItem sagGameItem,
    emit,
  ) {
    emit(state.idleState);
    switch (upsertResult) {
      case Success():
        emit(
          state.withSAGGameBSC(sagGame).withUserSAGGameId(upsertResult.data),
        );
        if (sagGame.isCompleted) {
          gameCompletedBGAudioPlayer?.resume();
        } else {
          add(
            LaunchSAGGameItemBE(
              state.nextSagGameItem(currentSAGGameItem: sagGameItem),
            ),
          );
        }
      case Error():
        final error = upsertResult.error;
        switch (error) {
          case UpsertUserSAGGameUseCaseSystemError():
            emit(state.withError(SAGGameViewSystemError()));
          case UpsertUserSAGGameUseCaseConnectionError():
            emit(
              state.withError(SAGGameViewConnectionError(sagGame, sagGameItem)),
            );
          case UpsertUserSAGGameUseCaseUnauthorizedError():
            _router.goNamed(signInRouteName);
        }
    }
  }

  FutureOr<void> _popBlocEvent(PopSAGGameBE event, Emitter<SAGGameBSC> emit) {
    _router.pop();
  }

  FutureOr<void> _addPointsSAGGameBE(event, emit) async {
    if (state.isSoundEnabled) inflatingPlayer?.resume();
    emit(state.claimingPoints);
    await Future.delayed(event.duration);
    if (state.isSoundEnabled) {
      inflatingPlayer?.stop();
      partyPopperPlayer?.resume();
    }
    final result = await _addCoinsStreamUseCase(state.sagGame.pointsGained);
    switch (result) {
      case Success():
        emit(state.withSAGGameBSC(state.sagGame!.claimed));
      case Error():
    }
  }

  FutureOr<void> _completeSAGGameBE(_, _) {
    _router.pop();
  }

  @override
  Future<void> close() {
    _gamesSettingsSubscription?.cancel();
    gameCompletedBGAudioPlayer?.stop();
    gameCompletedBGAudioPlayer?.dispose();
    inflatingPlayer?.stop();
    inflatingPlayer?.dispose();
    partyPopperPlayer?.stop();
    partyPopperPlayer?.dispose();
    return super.close();
  }
}
