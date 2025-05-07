import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';

part 'sag_games_bsc.freezed.dart';

@freezed
abstract class SAGGamesBSC with _$SAGGamesBSC {
  const factory SAGGamesBSC({List<PaginatedSagGames>? paginatedSagGamesList}) =
      _SAGGamesBSC;
}

extension SAGGamesBSCMutation on SAGGamesBSC {
  SAGGamesBSC withPaginatedSagGames(PaginatedSagGames paginatedSagGames) =>
      copyWith(
        paginatedSagGamesList: [
          ...(paginatedSagGamesList ?? []),
          paginatedSagGames,
        ],
      );
}

extension SAGGamesBSCQueries on SAGGamesBSC {
  bool doesPaginatedSagGamesListBecameAvailable(SAGGamesBSC nextState) =>
      paginatedSagGamesList.isNull && nextState.paginatedSagGamesList.isNotNull;

  List<SAGGame> get sagGamesBSCList =>
      paginatedSagGamesList?.fold([], (
        acc,
        PaginatedSagGames paginatedSagGames,
      ) {
        return [...acc!, ...paginatedSagGames.games];
      }) ??
      [];

  bool get isPaginatedSagGamesListLoading => paginatedSagGamesList == null;
}
