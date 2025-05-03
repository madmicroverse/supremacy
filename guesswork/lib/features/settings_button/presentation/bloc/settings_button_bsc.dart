import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';

part 'settings_button_bsc.freezed.dart';

@freezed
abstract class SettingsButtonBSC with _$SettingsButtonBSC {
  const factory SettingsButtonBSC() = _SettingsButtonBSC;
}
