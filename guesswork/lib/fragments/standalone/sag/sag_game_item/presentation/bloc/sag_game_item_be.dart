import 'dart:ui';

import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class SAGGameItemBE {}

class InitSAGGameItemBE extends SAGGameItemBE {
  final SAGGameItem sagGameItem;

  InitSAGGameItemBE(this.sagGameItem);
}

class InitAudioPlayersBE extends SAGGameItemBE {}

class InitGamesImageBE extends SAGGameItemBE {
  final String url;

  InitGamesImageBE(this.url);
}

class InitGameSettingsBE extends SAGGameItemBE {
  InitGameSettingsBE();
}

class GamesSettingsUpdateBE extends SAGGameItemBE {
  final GamesSettings gamesSettings;

  GamesSettingsUpdateBE(this.gamesSettings);
}

class InitPathBE extends SAGGameItemBE {
  final double width;
  final double height;

  InitPathBE(this.width, this.height);
}

class AddPathPointBE extends SAGGameItemBE {
  final Offset point;

  AddPathPointBE(this.point);
}

class GuessSAGGameItemBE extends SAGGameItemBE {
  final Option guess;

  GuessSAGGameItemBE(this.guess);
}

class ContinueSAGGameItemBE extends SAGGameItemBE {
  ContinueSAGGameItemBE();
}

class StopScratchPlayerBE extends SAGGameItemBE {}

class PopAfterUnknownErrorBE extends SAGGameItemBE {}
