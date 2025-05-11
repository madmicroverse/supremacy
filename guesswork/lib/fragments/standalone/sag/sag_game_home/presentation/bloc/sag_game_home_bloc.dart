import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/di/modules/router_module.dart';

import 'sag_game_home_be.dart';
import 'sag_game_home_bs.dart';

class SagGameHomeBloc extends Bloc<SagGameHomeBE, SagGameHomeBS> {
  final IRouter _router;

  SagGameHomeBloc(this._router) : super(SagGameHomeBS()) {
    on<InitSAGGameHomeBE>(_initSagGameHomeBlocEvent);
    on<SelectTabBE>(_selectItemBE);
  }

  FutureOr<void> _initSagGameHomeBlocEvent(
    InitSAGGameHomeBE event,
    Emitter<SagGameHomeBS> emit,
  ) async {}

  FutureOr<void> _selectItemBE(
    SelectTabBE event,
    Emitter<SagGameHomeBS> emit,
  ) async {
    switch (event.tab) {
      case SAGGameHomeTab.selection:
        _router.replaceNamed(sagGamesSelectionRouteName);
      case SAGGameHomeTab.replay:
        _router.replaceNamed(sagGamesReplyRouteName);
      case SAGGameHomeTab.main:
        _router.replaceNamed(sagGamesMainRouteName);
      case SAGGameHomeTab.top:
        _router.replaceNamed(sagGamesTopRouteName);
      case SAGGameHomeTab.event:
        _router.replaceNamed(sagGamesEventRouteName);
    }
    emit(state.withTab(event.tab));
  }
}
