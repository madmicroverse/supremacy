import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class SelectionButtonBE {}

class UpdateGameSelectionsBE extends SelectionButtonBE {
  SAGGame sagGame;
  List<SAGGame> gamesSelectionList;

  UpdateGameSelectionsBE(this.sagGame, this.gamesSelectionList);
}

class InitSAGGameSelectionBE extends SelectionButtonBE {
  SAGGame sagGame;

  InitSAGGameSelectionBE(this.sagGame);
}

class SelectionGameBE extends SelectionButtonBE {
  bool isSelection;
  SAGGame sagGameSelection;

  SelectionGameBE(this.sagGameSelection, this.isSelection);
}
