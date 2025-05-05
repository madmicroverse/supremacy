import 'package:freezed_annotation/freezed_annotation.dart';

part 'coins_bsc.freezed.dart';

@freezed
abstract class CoinsBSC with _$CoinsBSC {
  const factory CoinsBSC({int? amount}) = _CoinsBSC;
}

extension CoinsBSCMutations on CoinsBSC {
  CoinsBSC withAmount(int amount) => copyWith(amount: amount);
}

extension CoinsBSCQueries on CoinsBSC {
  bool get isLoadingAmount => amount == null;
}
