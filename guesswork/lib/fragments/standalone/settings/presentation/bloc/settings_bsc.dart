import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';

part 'settings_bsc.freezed.dart';

@freezed
abstract class SettingsBSC with _$SettingsBSC {
  const factory SettingsBSC({
    GamesSettings? gameSettings,
    String? version,
    SettingsError? settingsError,
  }) = _SettingsBSC;
}

extension SettingsBSCMutations on SettingsBSC {
  SettingsBSC withGamesSettings(GamesSettings gamesSettings) =>
      copyWith(gameSettings: gamesSettings);

  SettingsBSC withVersion(String version) => copyWith(version: version);

  SettingsBSC withError(SettingsError settingsError) =>
      copyWith(settingsError: settingsError);

  SettingsBSC get withoutError => copyWith(settingsError: settingsError);
}

extension SettingsBSCMutationsWueries on SettingsBSC {
  bool get isGameSettingsLoading => gameSettings == null;
}

sealed class SettingsError extends BaseError {}

class SettingsReadDataAccessError extends SettingsError {}

class SettingsSystemError extends SettingsError {}
