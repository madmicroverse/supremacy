import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/games.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/use_case/upsert_favorite_use_case.dart';

import 'favorite_button_be.dart';
import 'favorite_button_bsc.dart';

class FavoriteButtonBloc extends Bloc<FavoriteButtonBE, FavoriteButtonBS> {
  final IRouter _router;
  final UpsertGamesFavoriteUseCase _upsertGamesFavoriteUseCase;

  FavoriteButtonBloc(this._router, this._upsertGamesFavoriteUseCase)
    : super(FavoriteButtonBS()) {
    on<SelectSAGGameFavoriteBE>(_selectSAGGameFavoriteBE);
    on<InitSAGGameFavoriteBE>(_initSAGGameFavoriteBE);
  }

  FutureOr<void> _initSAGGameFavoriteBE(
    InitSAGGameFavoriteBE event,
    Emitter<FavoriteButtonBS> emit,
  ) async {
    await Future.delayed(3000.ms);
    emit(
      state.withOnPressed(() => add(SelectSAGGameFavoriteBE(event.sagGame))),
    );
  }

  FutureOr<void> _selectSAGGameFavoriteBE(
    SelectSAGGameFavoriteBE event,
    Emitter<FavoriteButtonBS> emit,
  ) async {
    final result = await _upsertGamesFavoriteUseCase(
      GamesFavorite(gameId: event.sagGame.id, gameType: GameType.sagGame),
    );
    switch (result) {
      case Success():
        print('');
      case Error():
        print('');
    }
  }
}
