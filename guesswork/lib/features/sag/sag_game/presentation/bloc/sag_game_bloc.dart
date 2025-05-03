import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/basic.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';
import 'package:guesswork/di/modules/router_module.dart';

import '../../domain/use_case/get_sag_game_use_case.dart';
import 'sag_game_be.dart';
import 'sag_game_bsc.dart';

class SAGGameBloc extends Bloc<SAGGameBE, BlocState<SAGGameBSC>> {
  final IRouter _router;
  final GetSAGGameUseCase _getGetScratchAndGuessGameSetUseCase;

  SAGGameBloc(this._router, this._getGetScratchAndGuessGameSetUseCase)
    : super(
        BlocState<SAGGameBSC>(
          status: LoadingStateStatus(),
          content: SAGGameBSC(),
        ),
      ) {
    on<PopSAGGameBE>(_popBlocEvent);
    on<InitSAGGameBE>(_initGameSetBlocEvent);
    on<IncreasePointsSAGGameBE>(_showNewUserPointsBlocEvent);
  }

  FutureOr<void> _initGameSetBlocEvent(
    InitSAGGameBE event,
    Emitter<BlocState<SAGGameBSC>> emit,
  ) async {
    SAGGame gameSet = await _getGetScratchAndGuessGameSetUseCase("");
    emit(
      state.idleState.copyWith(
        content: state.content.copyWith(gameSet: gameSet),
      ),
    );

    for (var guessGame in gameSet.guessGameList) {
      SAGGameItemAnswer? result;
      result = await _router.pushNamed<SAGGameItemAnswer>(
        sagGameItemRouteName,
        extra: guessGame.copyWith(setName: gameSet.title),
      );

      if (result.isNotNull) {
        final guessGameAnswerList = [
          ...state.content.guessGameAnswerList,
          result!,
        ];
        final totalPoints = guessGameAnswerList.fold(0, (prevVal, ans) {
          return prevVal +
              (ans.points * ans.revealedRatio.oneMinus * ans.isCorrect.intValue)
                  .toInt();
        });
        emit(
          state.copyWith(
            content: state.content.copyWith(
              guessGameAnswerList: guessGameAnswerList,
              isGameSetCompleted:
                  gameSet.guessGameList.length == guessGameAnswerList.length,
              totalPoints: totalPoints,
            ),
          ),
        );
      } else {
        return _router.pop();
      }
    }
  }

  FutureOr<void> _popBlocEvent(
    PopSAGGameBE event,
    Emitter<BlocState<SAGGameBSC>> emit,
  ) {
    _router.pop();
  }

  FutureOr<void> _showNewUserPointsBlocEvent(
    IncreasePointsSAGGameBE event,
    Emitter<BlocState<SAGGameBSC>> emit,
  ) async {
    emit(
      state.copyWith(
        content: state.content.copyWith(
          userPoints: state.content.userPoints + state.content.totalPoints,
        ),
      ),
    );
  }
}
