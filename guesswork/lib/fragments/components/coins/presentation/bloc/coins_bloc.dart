import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/constants/resources.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/fragments/components/coins/domain/use_case/get_coins_stream_use_case.dart';

import 'coins_be.dart';
import 'coins_bsc.dart';

class CoinsBloc extends Bloc<CoinsBE, CoinsBSC> {
  final IRouter _router;
  final GetCoinsStreamUseCase _getCoinsStreamUseCase;
  StreamSubscription<int>? _coinsAmountSubscription;

  CoinsBloc(this._router, this._getCoinsStreamUseCase) : super(CoinsBSC()) {
    on<InitCoinsBE>(_initCoinsBE);
    on<UpdateCoinsAmountBE>(_updateCoinsAmountBE);
    on<ShowUserDetailCoinsBE>(_showUserDetailCoinsBE);
    _initAudioPlayersBE();
  }

  FutureOr<void> _initCoinsBE(InitCoinsBE event, Emitter<CoinsBSC> emit) async {
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
    if ((state.amount ?? 0) > 0) {
      coinsIncreasingSoundPlayer?.resume();
    }
    emit(state.withAmount(event.amount));
  }

  FutureOr<void> _showUserDetailCoinsBE(
    ShowUserDetailCoinsBE event,
    Emitter<CoinsBSC> emit,
  ) {}

  _initAudioPlayersBE() async {
    coinsIncreasingSoundPlayer = AudioPlayer();
    coinsIncreasingSoundPlayer?.setVolume(0.25);
    coinsIncreasingSoundPlayer?.setReleaseMode(ReleaseMode.release);
    await coinsIncreasingSoundPlayer?.setSource(
      AudioAsset.coinsIncreasing.source,
    );
  }

  @override
  Future<void> close() {
    _coinsAmountSubscription?.cancel();
    coinsIncreasingSoundPlayer?.stop();
    coinsIncreasingSoundPlayer?.dispose();
    return super.close();
  }
}
