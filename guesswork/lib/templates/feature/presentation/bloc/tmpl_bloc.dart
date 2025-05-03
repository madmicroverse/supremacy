import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';

import 'tmpl_bloc_events.dart';
import 'tmpl_bloc_state.dart';

class TmplBloc extends Bloc<TmplBlocEvent, TmplBlocState> {
  final IRouter _router;

  TmplBloc(this._router) : super(TmplBlocState()) {
    on<PopTmplBlocEvent>(_popTmplBlocEvent);
    on<InitTmplBlocEvent>(_initTmplBlocEvent);
  }

  FutureOr<void> _initTmplBlocEvent(
    InitTmplBlocEvent event,
    Emitter<TmplBlocState> emit,
  ) async {}

  FutureOr<void> _popTmplBlocEvent(
    PopTmplBlocEvent event,
    Emitter<TmplBlocState> emit,
  ) async {}
}
