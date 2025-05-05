import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class SAGGameBE {}

class InitSAGGameBE extends SAGGameBE {
  final String sagGameId;

  InitSAGGameBE(this.sagGameId);
}

class InitAudioPlayersBE extends SAGGameBE {}

class InitSAGGameItemLoopBE extends SAGGameBE {
  final SAGGame sagGame;

  InitSAGGameItemLoopBE(this.sagGame);
}

class PopSAGGameBE extends SAGGameBE {
  PopSAGGameBE();
}

class ShowSAGGameBE extends SAGGameBE {
  ShowSAGGameBE();
}

class IncreasePointsSAGGameBE extends SAGGameBE {
  IncreasePointsSAGGameBE();
}
