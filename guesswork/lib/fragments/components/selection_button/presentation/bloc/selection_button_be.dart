import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/upsert_sag_game_selection_operation.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class SelectionButtonBE {}

class UpdateGameSelectionsBE extends SelectionButtonBE {
  SAGGame sagGame;
  List<SAGGame> gamesSelectionList;

  UpdateGameSelectionsBE(this.sagGame, this.gamesSelectionList);
}

class InitSAGGameSelectionBE extends SelectionButtonBE {
  LiveSAGGameSource liveSAGGameSource;
  SAGGame sagGame;

  InitSAGGameSelectionBE(this.liveSAGGameSource, this.sagGame);
}

class SelectionGameBE extends SelectionButtonBE {
  bool isSelection;
  SAGGame sagGameSelection;

  SelectionGameBE(this.sagGameSelection, this.isSelection);
}
