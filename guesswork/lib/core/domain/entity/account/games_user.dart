import 'package:freezed_annotation/freezed_annotation.dart';

part 'games_user.freezed.dart';
part 'games_user.g.dart';

@freezed
abstract class GamesUser with _$GamesUser {
  const factory GamesUser({
    required String id,
    required bool isAnonymous,
    required List<GamesUserInfo> gamesUserInfoList,
    int? points,
  }) = _GamesUser;

  factory GamesUser.fromJson(Map<String, dynamic> json) =>
      _$GamesUserFromJson(json);
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
