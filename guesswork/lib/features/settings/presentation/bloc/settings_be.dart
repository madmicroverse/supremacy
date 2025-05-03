import 'package:guesswork/core/domain/entity/settings/games_settings.dart';

sealed class SettingsBE {}

class InitSettingsBE extends SettingsBE {}

class UpdateSettingsBE extends SettingsBE {
  GamesSettings gameSettings;

  UpdateSettingsBE(this.gameSettings);
}

class SwitchSettingsBE extends SettingsBE {
  GamesSettings gameSettings;

  SwitchSettingsBE(this.gameSettings);
}
