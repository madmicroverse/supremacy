import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/sign_out_use_case.dart';
import 'package:guesswork/di/modules/router_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';

import '../../domain/use_case/get_sag_games_use_case.dart';
import 'sag_games_be.dart';
import 'sag_games_bsc.dart';

class SAGGamesBloc extends Bloc<SAGGamesBE, SAGGamesBSC> {
  final IRouter _router;
  final GetSAGGamesUseCase _getSAGGamesUseCase;
  final SignOutUseCase _signOutUseCase;

  SAGGamesBloc(this._router, this._getSAGGamesUseCase, this._signOutUseCase)
    : super(SAGGamesBSC()) {
    on<InitSAGGamesBlocEvent>(_initSAGGamesBlocEvent);
    on<SelectGameBlocEvent>(_selectGameBlocEvent);
  }

  FutureOr<void> _initSAGGamesBlocEvent(
    InitSAGGamesBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) async {

    switch (event.sagGameSource) {
      case SAGGameSource.main:
      case SAGGameSource.top:
      case SAGGameSource.replay:
        final result = await _getSAGGamesUseCase(
          sagGameSource: event.sagGameSource,
          limit: 10,
        );
        switch (result) {
          case Success():
            PaginatedSagGames paginatedSagGames = result.data;
            emit(state.withPaginatedSagGames(paginatedSagGames));
          case Error():
            print('');
        }
      case SAGGameSource.favorite:
        throw UnimplementedError();
    }
  }

  FutureOr<void> _selectGameBlocEvent(
    SelectGameBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) {
    _router.pushNamed(sagGameRouteName, extra: event.sagGame.id);
  }
}
