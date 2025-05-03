import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/account/games_user_progress.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';

part 'app_bar_bsc.freezed.dart';

@freezed
abstract class AppBarBSC with _$AppBarBSC {
  const factory AppBarBSC() = _AppBarBSC;
}
