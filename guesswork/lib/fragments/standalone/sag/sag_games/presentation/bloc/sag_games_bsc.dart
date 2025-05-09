import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';

part 'sag_games_bsc.freezed.dart';

@freezed
abstract class SAGGamesBSC with _$SAGGamesBSC {
  const factory SAGGamesBSC({List<SAGGame>? sagGameList}) = _SAGGamesBSC;
}

extension SAGGamesBSCMutation on SAGGamesBSC {
  SAGGamesBSC withSAGGameList(List<SAGGame> sagGameList) =>
      copyWith(sagGameList: sagGameList);
}

extension SAGGamesBSCQueries on SAGGamesBSC {
  bool doesSAGGameListBecameAvailable(SAGGamesBSC nextState) =>
      sagGameList.isNull && nextState.sagGameList.isNotNull;

  bool doesSAGGameListWasUpdated(SAGGamesBSC nextState) =>
      sagGameList != nextState.sagGameList;

  bool get isSAGGameListLoading => sagGameList == null;
}
