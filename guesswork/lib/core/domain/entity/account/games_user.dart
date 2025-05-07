import 'package:freezed_annotation/freezed_annotation.dart';

part 'games_user.freezed.dart';
part 'games_user.g.dart';

@freezed
abstract class GamesUser with _$GamesUser {
  const factory GamesUser({
    @JsonKey(includeToJson: false) required String id,
    required bool isAnonymous,
    required List<GamesUserInfo> gamesUserInfoList,
    required GamesUserProgress progress,
    required GamesSettings gamesSettings,
  }) = _GamesUser;

  factory GamesUser.fromJson(Map<String, dynamic> json) =>
      _$GamesUserFromJson(json);
}

extension GamesUserMutations on GamesUser {
  GamesUser withSettings(GamesSettings gamesSettings) =>
      copyWith(gamesSettings: gamesSettings);

  GamesUser addPoints(int points) =>
      copyWith(progress: progress.copyWith(points: progress.points + points));
}

@freezed
abstract class GamesUserInfo with _$GamesUserInfo {
  const factory GamesUserInfo({
    required String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    String? providerId,
  }) = _GamesUserInfo;

  factory GamesUserInfo.fromJson(Map<String, dynamic> json) =>
      _$GamesUserInfoFromJson(json);
}

@freezed
abstract class GamesSettings with _$GamesSettings {
  const factory GamesSettings({
    @Default(true) bool sound,
    @Default(true) bool music,
    @Default(true) bool haptic,
  }) = _GamesSettings;

  factory GamesSettings.fromJson(Map<String, dynamic> json) =>
      _$GamesSettingsFromJson(json);
}

// Primary objective of this extensions is not to validate the optional
extension GamesSettingsQueries on GamesSettings? {
  bool get isSoundEnabled => this?.sound ?? false;

  bool get isMusicEnabled => this?.music ?? false;

  bool get isHapticEnabled => this?.haptic ?? false;
}

@freezed
abstract class GamesUserProgress with _$GamesUserProgress {
  const factory GamesUserProgress({@Default(0) int points}) =
      _GamesUserProgress;

  factory GamesUserProgress.fromJson(Map<String, dynamic> json) =>
      _$GamesUserProgressFromJson(json);
}
