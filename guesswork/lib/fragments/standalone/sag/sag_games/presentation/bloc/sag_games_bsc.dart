import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';

part 'sag_games_bsc.freezed.dart';

@freezed
abstract class SAGGamesBSC with _$SAGGamesBSC {
  const factory SAGGamesBSC({
    SAGGameSource? sagGameSource,
    List<SAGGame>? sagGameList,
    SAGGamesBSCViewError? sagGamesBSCError,
  }) = _SAGGamesBSC;
}

extension SAGGamesBSCMutation on SAGGamesBSC {
  SAGGamesBSC withSAGGameSource(SAGGameSource sagGameSource) =>
      copyWith(sagGameSource: sagGameSource);

  SAGGamesBSC withSAGGameList(List<SAGGame> sagGameList) =>
      copyWith(sagGameList: sagGameList);

  SAGGamesBSC get withEmptySAGGameList => copyWith(sagGameList: []);

  SAGGamesBSC withError(SAGGamesBSCViewError sagGamesBSCError) =>
      copyWith(sagGamesBSCError: sagGamesBSCError);
}

extension SAGGamesBSCQueries on SAGGamesBSC {
  bool doesSAGGameListBecameAvailable(SAGGamesBSC nextState) =>
      sagGameList.isNull && nextState.sagGameList.isNotNull;

  bool doesSAGGameListWasUpdated(SAGGamesBSC nextState) =>
      sagGameList != nextState.sagGameList;

  bool get isSAGGameListLoading => sagGameList == null;

  bool isSAGGamesBSCViewError(SAGGamesBSC nextState) =>
      sagGamesBSCError != nextState.sagGamesBSCError &&
      nextState.sagGamesBSCError != null;

  bool get isSAGGamesRefreshable =>
      sagGameSource.isNotNull &&
      sagGameList.isNotNull &&
      sagGameList!.isEmpty &&
      sagGameSource != SAGGameSource.selection;
}

sealed class SAGGamesBSCViewError extends BaseError {}

class SAGGamesBSCUnknownError extends SAGGamesBSCViewError {}
