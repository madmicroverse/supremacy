import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';

part 'no_ads_button_bsc.freezed.dart';

@freezed
abstract class NoAdsButtonBSC with _$NoAdsButtonBSC {
  const factory NoAdsButtonBSC({int? amount}) = _NoAdsButtonBSC;
}
