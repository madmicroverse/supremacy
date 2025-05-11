import 'dart:async';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_sag_game_selections_stream_use_case.dart';
import 'package:guesswork/di/modules/router_module.dart';
import 'package:guesswork/fragments/components/selection_button/domain/use_case/delete_sag_game_selection_use_case.dart';
import 'package:guesswork/fragments/components/selection_button/domain/use_case/upsert_sag_game_selection_use_case.dart';

import 'selection_button_be.dart';
import 'selection_button_bs.dart';

class SelectionButtonBloc extends Bloc<SelectionButtonBE, SelectionButtonBS> {
  final IRouter _router;
  final UpsertSAGGameSelectionUseCase _upsertGamesSelectionUseCase;
  final GetSAGGameSelectionsStreamUseCase _getGamesSelectionsStreamUseCase;
  final DeleteSAGGameSelectionUseCase _deleteSAGGameSelectionUseCase;

  StreamSubscription<List<SAGGame>>? _sagGameSelectionListSubscription;

  SelectionButtonBloc(
    this._router,
    this._upsertGamesSelectionUseCase,
    this._getGamesSelectionsStreamUseCase,
    this._deleteSAGGameSelectionUseCase,
  ) : super(SelectionButtonBS()) {
    on<UpdateGameSelectionsBE>(_updateGameSelectionsBE);
    on<SelectionGameBE>(_selectionGameBE);
    on<InitSAGGameSelectionBE>(_initSAGGameSelectionBE);
  }

  FutureOr<void> _updateGameSelectionsBE(
    UpdateGameSelectionsBE event,
    Emitter<SelectionButtonBS> emit,
  ) {
    final isSelection =
        event.gamesSelectionList.firstWhereOrNull((gamesSelection) {
          return gamesSelection.id == event.sagGame.id;
        }).isNotNull;

    selectionEvent() => add(SelectionGameBE(event.sagGame, isSelection));

    emit(state.withOnPressed(selectionEvent).withIsSelection(isSelection));
  }

  FutureOr<void> _initSAGGameSelectionBE(
    InitSAGGameSelectionBE event,
    Emitter<SelectionButtonBS> emit,
  ) async {
    final result = await _getGamesSelectionsStreamUseCase();
    switch (result) {
      case Success():
        _sagGameSelectionListSubscription = result.data.listen((
          gamesSelectionList,
        ) {
          add(UpdateGameSelectionsBE(event.sagGame, gamesSelectionList));
        });
      case Error():
        final error = result.error;
        switch (error) {
          case GetSAGGameSelectionsStreamUseCaseDataAccessError():
            emit(state.withError(SelectionButtonViewDataAccessError()));
          case GetSAGGameSelectionsStreamUseCaseUnauthorizedError():
            _router.goNamed(signInRouteName);
        }
    }
  }

  FutureOr<void> _selectionGameBE(
    SelectionGameBE event,
    Emitter<SelectionButtonBS> emit,
  ) async {
    if (event.isSelection) {
      final result = await _deleteSAGGameSelectionUseCase(
        event.sagGameSelection.id,
      );
      switch (result) {
        case Success():
          break;
        case Error():
          final error = result.error;
          switch (error) {
            case DeleteSAGGameSelectionUseCaseUnauthorizedError():
              _router.goNamed(signInRouteName);
            case DeleteSAGGameSelectionUseCaseDataAccessError():
              emit(state.withError(SelectionButtonViewDataAccessError()));
          }
      }
    } else {
      final result = await _upsertGamesSelectionUseCase(event.sagGameSelection);
      switch (result) {
        case Success():
          break;
        case Error():
          final error = result.error;
          switch (error) {
            case UpsertSAGGameSelectionUseCaseUnauthorizedError():
              _router.goNamed(signInRouteName);
            case UpsertSAGGameSelectionUseCaseDataAccessError():
              emit(state.withError(SelectionButtonViewDataAccessError()));
          }
      }
    }
  }

  @override
  Future<void> close() {
    _sagGameSelectionListSubscription?.cancel();
    return super.close();
  }
}
