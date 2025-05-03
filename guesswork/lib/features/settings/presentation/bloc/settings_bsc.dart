import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';

part 'settings_bsc.freezed.dart';

@freezed
abstract class SettingsBSC with _$SettingsBSC {
  const factory SettingsBSC({GamesSettings? gameSettings}) = _SettingsBSC;
}

extension BlocStateSettingsBSC on BlocState<SettingsBSC> {
  BlocState<SettingsBSC> withGamesSettings(GamesSettings gamesSettings) =>
      copyWith(content: content.copyWith(gameSettings: gamesSettings));
}
