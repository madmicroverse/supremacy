import 'package:freezed_annotation/freezed_annotation.dart';

part 'sag_game_home_bs.freezed.dart';

enum SAGGameHomeTab {
  favorite(0),
  replay(1),
  main(2),
  top(3),
  event(4);

  final int i;

  const SAGGameHomeTab(this.i);

  static SAGGameHomeTab fromInt(int value) {
    return SAGGameHomeTab.values.firstWhere(
      (element) => element.i == value,
      orElse: () => SAGGameHomeTab.main, // Default if no match is found
    );
  }
}

@freezed
abstract class SagGameHomeBS with _$SagGameHomeBS {
  const factory SagGameHomeBS({
    @Default(SAGGameHomeTab.main) SAGGameHomeTab tab,
  }) = _SagGameHomeBS;
}

extension SagGameHomeBSMutations on SagGameHomeBS {
  SagGameHomeBS withTab(SAGGameHomeTab tab) => copyWith(tab: tab);
}

extension SagGameHomeBSStateUtils on SagGameHomeBS {
  // bool isLoadingCompleted(SagGameHomeBS nextState) =>
  //     isLoading && !nextState.isLoading;
}
