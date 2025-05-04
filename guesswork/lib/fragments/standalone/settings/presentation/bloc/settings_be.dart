
import 'package:guesswork/core/domain/entity/account/games_user.dart';

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
