import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class SAGGameBE {}

class InitSAGGameBE extends SAGGameBE {
  final SAGGame sagGame;

  InitSAGGameBE(this.sagGame);
}

class InitAudioPlayersBE extends SAGGameBE {}

class LaunchSAGGameItemBE extends SAGGameBE {
  SAGGameItem sagGameItem;

  LaunchSAGGameItemBE(this.sagGameItem);
}

class RetryUpsertSAGGameBE extends SAGGameBE {
  SAGGame sagGame;
  SAGGameItem sagGameItem;

  RetryUpsertSAGGameBE(this.sagGame, this.sagGameItem);
}

class PopSAGGameBE extends SAGGameBE {}

class ShowSAGGameBE extends SAGGameBE {}

class AddPointsSAGGameBE extends SAGGameBE {
  Duration duration;

  AddPointsSAGGameBE(this.duration);
}

class CompleteSAGGameBE extends SAGGameBE {}

class GamesSettingsUpdateBE extends SAGGameBE {
  final GamesSettings gamesSettings;

  GamesSettingsUpdateBE(this.gamesSettings);
}

class PopAfterUnknownErrorBE extends SAGGameBE {}
