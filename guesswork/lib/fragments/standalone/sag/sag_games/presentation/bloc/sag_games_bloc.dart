import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/sign_out_use_case.dart';
import 'package:guesswork/di/modules/router_module.dart';

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
    on<SignOutBlocEvent>(_signOutBlocEvent);
  }

  FutureOr<void> _initSAGGamesBlocEvent(
    InitSAGGamesBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) async {
    List<SAGGamePreview> sagGamePreviewList = await _getSAGGamesUseCase();

    emit(state.copyWith(sagGamePreviewList: sagGamePreviewList));
  }

  FutureOr<void> _selectGameBlocEvent(
    SelectGameBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) {
    _router.pushNamed(sagGameRouteName, extra: event.sagGamePreview.id);
  }

  FutureOr<void> _signOutBlocEvent(
    SignOutBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) async {
    emit(state);
    await _signOutUseCase();
    _router.replaceNamed(signInRouteName);
  }
}
