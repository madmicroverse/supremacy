import 'package:freezed_annotation/freezed_annotation.dart';

part 'games_settings.freezed.dart';
part 'games_settings.g.dart';

@freezed
abstract class GamesSettings with _$GamesSettings {
  const factory GamesSettings({
    @Default("") String id,
    @Default(true) bool sound,
    @Default(true) bool music,
    @Default(true) bool haptic,
    int? points,
  }) = _GamesSettings;

  factory GamesSettings.fromJson(Map<String, dynamic> json) =>
      _$GamesSettingsFromJson(json);
}
