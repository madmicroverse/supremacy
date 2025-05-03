import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class SAGGamesBE {}

class InitSAGGamesBlocEvent extends SAGGamesBE {
  InitSAGGamesBlocEvent();
}

class SelectGameBlocEvent extends SAGGamesBE {
  final SAGGamePreview sagGamePreview;

  SelectGameBlocEvent(this.sagGamePreview);
}

class SignOutBlocEvent extends SAGGamesBE {
  SignOutBlocEvent();
}
