import 'package:freezed_annotation/freezed_annotation.dart';

part 'games_user_progress.freezed.dart';
part 'games_user_progress.g.dart';

@freezed
abstract class GamesUserProgress with _$GamesUserProgress {
  const factory GamesUserProgress({required int points}) = _GamesUserProgress;

  factory GamesUserProgress.fromJson(Map<String, dynamic> json) =>
      _$GamesUserProgressFromJson(json);
}
