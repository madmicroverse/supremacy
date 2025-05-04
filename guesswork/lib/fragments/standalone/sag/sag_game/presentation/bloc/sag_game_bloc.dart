import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/basic.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/di/modules/router_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/use_case/create_sag_game_use_case.dart';

import '../../domain/use_case/get_sag_game_use_case.dart';
import 'sag_game_be.dart';
import 'sag_game_bsc.dart';

class SAGGameBloc extends Bloc<SAGGameBE, SAGGameBSC> {
  final IRouter _router;
  final GetSAGGameUseCase _getSAGGameUseCase;
  final CreateSAGGameUseCase _createSAGGameUseCase;

  SAGGameBloc(this._router, this._getSAGGameUseCase, this._createSAGGameUseCase)
    : super(SAGGameBSC()) {
    on<PopSAGGameBE>(_popBlocEvent);
    on<InitSAGGameBE>(_initGameSetBlocEvent);
    on<InitSAGGameItemLoopBE>(_initSAGGameItemLoopBE);
    on<IncreasePointsSAGGameBE>(_showNewUserPointsBlocEvent);
  }

  FutureOr<void> _initGameSetBlocEvent(
    InitSAGGameBE event,
    Emitter<SAGGameBSC> emit,
  ) async {
    final result = await _getSAGGameUseCase(event.sagGameId);
    switch (result) {
      case Success():
        emit(state.withSAGGameBSC(result.data));
        add(InitSAGGameItemLoopBE(result.data));
      case Error():
        throw UnimplementedError();
    }
  }

  FutureOr<void> _initSAGGameItemLoopBE(
    InitSAGGameItemLoopBE event,
    Emitter<SAGGameBSC> emit,
  ) async {
    for (var guessGame in event.sagGame.guessGameList) {
      SAGGameItemAnswer? result;
      result = await _router.pushNamed<SAGGameItemAnswer>(
        sagGameItemRouteName,
        extra: guessGame.copyWith(setName: event.sagGame.title),
      );

      if (result.isNotNull) {
        final guessGameAnswerList = [...state.guessGameAnswerList, result!];
        final totalPoints = guessGameAnswerList.fold(0, (prevVal, ans) {
          return prevVal +
              (ans.points * ans.revealedRatio.oneMinus * ans.isCorrect.intValue)
                  .toInt();
        });
        emit(
          state.copyWith(
            guessGameAnswerList: guessGameAnswerList,
            isGameSetCompleted:
                event.sagGame.guessGameList.length ==
                guessGameAnswerList.length,
            totalPoints: totalPoints,
          ),
        );
      } else {
        return _router.pop();
      }
    }
  }

  FutureOr<void> _popBlocEvent(PopSAGGameBE event, Emitter<SAGGameBSC> emit) {
    _router.pop();
  }

  FutureOr<void> _showNewUserPointsBlocEvent(
    IncreasePointsSAGGameBE event,
    Emitter<SAGGameBSC> emit,
  ) async {
    emit(state.copyWith(userPoints: state.userPoints + state.totalPoints));
  }
}
