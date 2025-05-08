import 'dart:async';

import 'package:guesswork/core/data/framework/firebase/firestore/get_games_user_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/get_games_user_stream_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/set_games_user_operation.dart';
import 'package:guesswork/core/data/framework/firebase/user_framework.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:rxdart/rxdart.dart';

class AccountRepositoryImpl extends AccountRepository {
  final GetAuthGamesUserOperation _getAuthGamesUserOperation;
  final GetGamesUserOperation _getGamesUserOperation;
  final GetGamesUserStreamOperation _getGamesUserStreamOperation;
  final SetGamesUserOperation _setGamesUserOperation;

  Stream<GamesUser>? _gamesUserStream;

  final _gamesUserBehaviorSubject = BehaviorSubject<GamesUser>();

  StreamSubscription? _gamesUserStreamSubscription;

  AccountRepositoryImpl(
    this._getAuthGamesUserOperation,
    this._getGamesUserOperation,
    this._getGamesUserStreamOperation,
    this._setGamesUserOperation,
  );

  @override
  Future<Result<GamesUser, BaseError>> getGamesUser() async {
    final authResult = await _getAuthGamesUserOperation();
    switch (authResult) {
      case Success():
        return _getGamesUserOperation(authResult.data);
      case Error():
        return authResult;
    }
  }

  @override
  Future<Result<void, BaseError>> upsertGamesUser(GamesUser gamesUser) =>
      _setGamesUserOperation(gamesUser);

  @override
  Future<Result<Stream<GamesUser>, BaseError>> getGamesUserStream() async {
    if (_gamesUserStream == null) {
      final result = await _getAuthGamesUserOperation();
      switch (result) {
        case Success():
          final streamResult = await _getGamesUserStreamOperation(result.data);
          switch (streamResult) {
            case Success():
              _gamesUserStream = streamResult.data;
              _gamesUserStreamSubscription = _gamesUserStream!.listen(
                (favorites) {
                  _gamesUserBehaviorSubject.add(favorites);
                },
                onError: (error) {
                  _gamesUserBehaviorSubject.addError(error);
                },
              );
            case Error():
              return Error(streamResult.error);
          }
        case Error():
          return Error(result.error);
      }
    }

    return Success(_gamesUserBehaviorSubject.stream);
  }
}
