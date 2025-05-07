import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class SAGGamesBE {}

class InitSAGGamesBlocEvent extends SAGGamesBE {
  InitSAGGamesBlocEvent();
}

class SelectGameBlocEvent extends SAGGamesBE {
  final SAGGame sagGame;

  SelectGameBlocEvent(this.sagGame);
}

class SignOutBlocEvent extends SAGGamesBE {
  SignOutBlocEvent();
}
