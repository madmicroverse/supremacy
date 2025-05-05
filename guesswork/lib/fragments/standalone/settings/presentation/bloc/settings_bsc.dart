import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';

part 'settings_bsc.freezed.dart';

@freezed
abstract class SettingsBSC with _$SettingsBSC {
  const factory SettingsBSC({GamesSettings? gameSettings}) = _SettingsBSC;
}

extension SettingsBSCMutations on SettingsBSC {
  SettingsBSC withGamesSettings(GamesSettings gamesSettings) =>
      copyWith(gameSettings: gamesSettings);
}

extension SettingsBSCMutationsWueries on SettingsBSC {
  bool get isGameSettingsLoading => gameSettings == null;
}
