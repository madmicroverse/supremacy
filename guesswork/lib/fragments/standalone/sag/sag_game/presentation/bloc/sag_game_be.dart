import 'package:guesswork/core/domain/entity/account/games_user.dart';

sealed class SAGGameBE {}

class InitSAGGameBE extends SAGGameBE {
  final String sagGameId;

  InitSAGGameBE(this.sagGameId);
}

class InitAudioPlayersBE extends SAGGameBE {}

class InitSAGGameItemLoopBE extends SAGGameBE {}

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
