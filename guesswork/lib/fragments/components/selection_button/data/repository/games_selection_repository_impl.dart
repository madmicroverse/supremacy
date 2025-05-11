import 'dart:async';

import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/delete_sag_game_selection_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/get_sag_games_selections_stream_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/upsert_sag_game_selection_operation.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/fragments/components/selection_button/domain/repository/games_selection_repository.dart';
import 'package:rxdart/rxdart.dart';

class GamesSelectionRepositoryImpl extends SAGGameSelectionRepository {
  final UpsertSAGGameSelectionOperation _upsertSAGGameSelectionOperation;
  final GetSAGGameSelectionsStreamOperation
  _getSAGGameSelectionsStreamOperation;
  final DeleteSAGGameSelectionOperation _deleteSAGGameSelectionOperation;

  Stream<List<SAGGame>>? _gamesSelectionsStream;

  final _gamesSelectionsBehaviorSubject = BehaviorSubject<List<SAGGame>>();

  GamesSelectionRepositoryImpl(
    this._upsertSAGGameSelectionOperation,
    this._getSAGGameSelectionsStreamOperation,
    this._deleteSAGGameSelectionOperation,
  );

  @override
  Future<
    Result<
      Stream<List<SAGGame>>,
      SAGGameSelectionRepositoryGetSAGGameSelectionsStreamError
    >
  >
  getSAGGameSelectionsStream(String gamesUserId) async {
    if (_gamesSelectionsStream == null) {
      final result = await _getSAGGameSelectionsStreamOperation(
        gamesUserId: gamesUserId,
      );
      switch (result) {
        case Success():
          _gamesSelectionsStream = result.data;
          _gamesSelectionsStream!.listen(
            (selections) {
              _gamesSelectionsBehaviorSubject.add(selections);
            },
            onError: (error) {
              _gamesSelectionsBehaviorSubject.addError(error);
            },
          );
        case Error():
          final error = result.error;
          switch (error) {
            case GetSAGGameSelectionsStreamOperationDataAccessError():
              return Error(
                SAGGameSelectionRepositoryGetSAGGameSelectionsStreamDataAccessError(),
              );
          }
      }
    }
    return Success(_gamesSelectionsBehaviorSubject.stream);
  }

  @override
  Future<Result<void, SAGGameSelectionRepositoryUpsertSAGGameSelectionError>>
  upsertSAGGameSelection(String gamesUserId, SAGGame sagGameSelection) async {
    final result = await _upsertSAGGameSelectionOperation(
      gamesUserId,
      sagGameSelection,
    );
    switch (result) {
      case Success():
        return Success(result.data);
      case Error():
        final error = result.error;
        switch (error) {
          case UpsertSAGGameSelectionOperationDataAccessError():
            return Error(
              SAGGameSelectionRepositoryUpsertSAGGameSelectionDataAccessError(),
            );
        }
    }
  }

  @override
  Future<Result<void, SAGGameSelectionRepositoryDeleteSAGGameSelectionError>>
  deleteSAGGameSelection(String gamesUserId, String sagGameSelectionId) async {
    final result = await _deleteSAGGameSelectionOperation(
      gamesUserId,
      sagGameSelectionId,
    );

    switch (result) {
      case Success():
        return Success(result.data);
      case Error():
        final error = result.error;
        switch (error) {
          case DeleteSAGGameSelectionOperationDataAccessError():
            return Error(
              SAGGameSelectionRepositoryDeleteSAGGameSelectionDataAccessError(),
            );
        }
    }
  }
}
