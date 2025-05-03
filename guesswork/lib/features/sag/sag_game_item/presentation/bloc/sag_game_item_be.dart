import 'dart:ui';

import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';

sealed class SAGGameItemBE {}

class InitSAGGameItemBE extends SAGGameItemBE {
  final SAGGameItem sagGameItem;

  InitSAGGameItemBE(this.sagGameItem);
}

class InitAudioPlayersBE extends SAGGameItemBE {}

class StopScratchPlayerBE extends SAGGameItemBE {}

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

class LoadImageSAGGameItemBE extends SAGGameItemBE {
  final String url;

  LoadImageSAGGameItemBE(this.url);
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

class UpdateProgressInfoBE extends SAGGameItemBE {
  final Set<Offset> revealedPoints;
  final double revealedRatio;

  UpdateProgressInfoBE(this.revealedPoints, this.revealedRatio);
}

class GuessSAGGameItemBE extends SAGGameItemBE {
  final Option guess;

  GuessSAGGameItemBE(this.guess);
}

class ContinueSAGGameItemBE extends SAGGameItemBE {
  ContinueSAGGameItemBE();
}
