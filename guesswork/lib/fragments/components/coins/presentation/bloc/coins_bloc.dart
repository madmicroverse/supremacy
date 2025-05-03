import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_game_user_info_use_case.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';

import 'coins_be.dart';
import 'coins_bsc.dart';

class CoinsBloc extends Bloc<CoinsBE, BlocState<CoinsBSC>> {
  final IRouter _router;
  final GetGamesUserInfoUseCase _getGamesUserInfoUseCase;

  CoinsBloc(this._router, this._getGamesUserInfoUseCase)
    : super(
        BlocState<CoinsBSC>(status: LoadingStateStatus(), content: CoinsBSC()),
      ) {
    on<InitCoinsBE>(_initCoinsBE);
  }

  FutureOr<void> _initCoinsBE(
    InitCoinsBE event,
    Emitter<BlocState<CoinsBSC>> emit,
  ) async {
    final result = await _getGamesUserInfoUseCase();
    await Future.delayed(3000.ms);
    switch (result) {
      case Success():
        return emit(state.idleState.withAmount(result.data.points));
      case Error():
        switch (result.error) {
          default:
            return emit(state.errorState(result.error.toString()));
        }
    }
  }
}
