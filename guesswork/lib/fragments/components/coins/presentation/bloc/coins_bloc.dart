import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/constants/resources.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/extension/audio_player.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/fragments/components/coins/domain/use_case/get_coins_stream_use_case.dart';
import 'package:guesswork/fragments/standalone/settings/domain/use_case/get_game_settings_stream_use_case.dart';

import 'coins_be.dart';
import 'coins_bsc.dart';

class CoinsBloc extends Bloc<CoinsBE, CoinsBSC> {
  final IRouter _router;
  final GetCoinsStreamUseCase _getCoinsStreamUseCase;
  final GetGamesSettingsStreamUseCase _getGamesSettingsUseCase;

  StreamSubscription<GamesSettings>? _gamesSettingsSubscription;
  StreamSubscription<int>? _coinsAmountSubscription;

  CoinsBloc(
    this._router,
    this._getCoinsStreamUseCase,
    this._getGamesSettingsUseCase,
  ) : super(CoinsBSC()) {
    on<InitCoinsBE>(_initCoinsBE);
    on<UpdateCoinsAmountBE>(_updateCoinsAmountBE);
    on<GamesSettingsUpdateBE>(_gamesSettingsUpdateBE);
    _initAudioPlayersBE();
  }

  FutureOr<void> _initCoinsBE(InitCoinsBE event, Emitter<CoinsBSC> emit) async {
    _initGameSettingsBE();
    final result = await _getCoinsStreamUseCase();
    switch (result) {
      case Success():
        _coinsAmountSubscription = result.data.listen(
          (coinsAmount) => add(UpdateCoinsAmountBE(coinsAmount)),
        );
      case Error():
        switch (result.error) {
          default:
          // return emit(state.errorState(result.error.toString()));
        }
    }
  }

  AudioPlayer? coinsIncreasingSoundPlayer;

  FutureOr<void> _updateCoinsAmountBE(
    UpdateCoinsAmountBE event,
    Emitter<CoinsBSC> emit,
  ) async {
    if (state.isSoundEnabled &&
        !coinsIncreasingSoundPlayer.isPlaying &&
        !state.isLoadingAmount) {
      coinsIncreasingSoundPlayer?.safeStop;
      coinsIncreasingSoundPlayer?.safeResume;
    }
    emit(state.withAmount(event.amount));
  }

  _initAudioPlayersBE() async {
    coinsIncreasingSoundPlayer = AudioPlayer();
    coinsIncreasingSoundPlayer?.setVolume(0.25);
    coinsIncreasingSoundPlayer?.setReleaseMode(ReleaseMode.release);
    await coinsIncreasingSoundPlayer?.setSource(
      AudioAsset.coinsIncreasing.source,
    );
  }

  FutureOr<void> _gamesSettingsUpdateBE(
    GamesSettingsUpdateBE event,
    Emitter<CoinsBSC> emit,
  ) {
    emit(state.withGamesSettings(event.gamesSettings));
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

  @override
  Future<void> close() {
    _gamesSettingsSubscription?.cancel();
    _coinsAmountSubscription?.cancel();
    coinsIncreasingSoundPlayer?.stop();
    coinsIncreasingSoundPlayer?.dispose();
    return super.close();
  }
}
