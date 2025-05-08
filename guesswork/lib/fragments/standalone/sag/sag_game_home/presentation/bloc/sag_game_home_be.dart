import 'sag_game_home_bs.dart';

sealed class SagGameHomeBE {}

class InitSAGGameHomeBE extends SagGameHomeBE {}

class SelectTabBE extends SagGameHomeBE {
  SAGGameHomeTab tab;

  SelectTabBE(this.tab);
}
