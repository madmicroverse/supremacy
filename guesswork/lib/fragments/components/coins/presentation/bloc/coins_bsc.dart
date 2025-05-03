import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';

part 'coins_bsc.freezed.dart';

@freezed
abstract class CoinsBSC with _$CoinsBSC {
  const factory CoinsBSC({int? amount}) = _CoinsBSC;
}

extension BlocStateCoinsBSC on BlocState<CoinsBSC> {
  BlocState<CoinsBSC> withAmount(int amount) =>
      copyWith(content: content.copyWith(amount: amount));
}
