import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/widgets/backgound_widget.dart';

import '../bloc/sag_games_be.dart';
import '../bloc/sag_games_bloc.dart';
import '../bloc/sag_games_bsc.dart';
import 'game_card.dart';

class SAGGamesRouteWidget extends StatelessWidget {
  final PreferredSizeWidget appBar;

  const SAGGamesRouteWidget({super.key, required this.appBar});

  SAGGamesBloc _bloc(BuildContext context) => context.read<SAGGamesBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: BackgroundWidget(
        child: BlocBuilder<SAGGamesBloc, SAGGamesBSC>(
          buildWhen:
              (state, nextState) =>
                  state.doesPaginatedSagGamesListBecameAvailable(nextState),
          builder: (context, state) {
            if (state.isPaginatedSagGamesListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              );
            }
            final sagGameList = state.sagGamesBSCList;
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: sagGameList.length,
              itemBuilder: (context, index) {
                final sagGame = sagGameList[index];
                return GameCard(
                  sagGame: sagGame,
                  onTap: () {
                    _bloc(context).add(SelectGameBlocEvent(sagGame));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
