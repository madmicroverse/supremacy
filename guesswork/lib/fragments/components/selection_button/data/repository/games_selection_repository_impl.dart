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

  Stream<List<SAGGame>>? _gamesFavoriteStream;
  final _gamesFavoriteBehaviorSubject = BehaviorSubject<List<SAGGame>>();

  Stream<List<SAGGame>>? _gamesTopStream;
  final _gamesTopBehaviorSubject = BehaviorSubject<List<SAGGame>>();

  Stream<List<SAGGame>>? _gamesEventStream;
  final _gamesEventBehaviorSubject = BehaviorSubject<List<SAGGame>>();

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
  getSAGGameSelectionsStream(
    LiveSAGGameSource liveSAGGameSource,
    String gamesUserId,
  ) async {
    switch (liveSAGGameSource) {
      case LiveSAGGameSource.favorites:
        return _favoriteStream(liveSAGGameSource, gamesUserId);
      case LiveSAGGameSource.top:
        return _topStream(liveSAGGameSource, gamesUserId);
      case LiveSAGGameSource.event:
        return _eventStream(liveSAGGameSource, gamesUserId);
    }
  }

  Future<
    Result<
      Stream<List<SAGGame>>,
      SAGGameSelectionRepositoryGetSAGGameSelectionsStreamError
    >
  >
  _favoriteStream(
    LiveSAGGameSource liveSAGGameSource,
    String gamesUserId,
  ) async {
    if (_gamesFavoriteStream == null) {
      final result = await _getSAGGameSelectionsStreamOperation(
        liveSAGGameSource: liveSAGGameSource,
        gamesUserId: gamesUserId,
      );
      switch (result) {
        case Success():
          _gamesFavoriteStream = result.data;
          _gamesFavoriteStream!.listen(
            (selections) {
              _gamesFavoriteBehaviorSubject.add(selections);
            },
            onError: (error) {
              _gamesFavoriteBehaviorSubject.addError(error);
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
    return Success(_gamesFavoriteBehaviorSubject.stream);
  }

  Future<
    Result<
      Stream<List<SAGGame>>,
      SAGGameSelectionRepositoryGetSAGGameSelectionsStreamError
    >
  >
  _topStream(LiveSAGGameSource liveSAGGameSource, String gamesUserId) async {
    if (_gamesTopStream == null) {
      final result = await _getSAGGameSelectionsStreamOperation(
        liveSAGGameSource: liveSAGGameSource,
        gamesUserId: gamesUserId,
      );
      switch (result) {
        case Success():
          _gamesTopStream = result.data;
          _gamesTopStream!.listen(
            (selections) {
              _gamesTopBehaviorSubject.add(selections);
            },
            onError: (error) {
              _gamesTopBehaviorSubject.addError(error);
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
    return Success(_gamesTopBehaviorSubject.stream);
  }

  Future<
    Result<
      Stream<List<SAGGame>>,
      SAGGameSelectionRepositoryGetSAGGameSelectionsStreamError
    >
  >
  _eventStream(LiveSAGGameSource liveSAGGameSource, String gamesUserId) async {
    if (_gamesEventStream == null) {
      final result = await _getSAGGameSelectionsStreamOperation(
        liveSAGGameSource: liveSAGGameSource,
        gamesUserId: gamesUserId,
      );
      switch (result) {
        case Success():
          _gamesEventStream = result.data;
          _gamesEventStream!.listen(
            (selections) {
              _gamesEventBehaviorSubject.add(selections);
            },
            onError: (error) {
              _gamesEventBehaviorSubject.addError(error);
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
    return Success(_gamesEventBehaviorSubject.stream);
  }

  @override
  Future<Result<void, SAGGameSelectionRepositoryUpsertSAGGameSelectionError>>
  upsertSAGGameSelection(
    LiveSAGGameSource liveSAGGameSource,
    String gamesUserId,
    SAGGame sagGameSelection,
  ) async {
    final result = await _upsertSAGGameSelectionOperation(
      liveSAGGameSource,
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
