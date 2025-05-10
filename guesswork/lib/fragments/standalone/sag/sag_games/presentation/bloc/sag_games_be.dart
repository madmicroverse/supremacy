import 'dart:async';

import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';

sealed class SAGGamesBE {}

class InitSAGGamesBlocEvent extends SAGGamesBE {
  final SAGGameSource sagGameSource;

  InitSAGGamesBlocEvent(this.sagGameSource);
}

class SelectGameBlocEvent extends SAGGamesBE {
  final SAGGame sagGame;

  SelectGameBlocEvent(this.sagGame);
}

class UpdateSAGGameListBlocEvent extends SAGGamesBE {
  final List<SAGGame> sagGameList;

  UpdateSAGGameListBlocEvent(this.sagGameList);
}

class PullToRefreshBlocEvent extends SAGGamesBE {
  final Completer completer;

  PullToRefreshBlocEvent(this.completer);
}
