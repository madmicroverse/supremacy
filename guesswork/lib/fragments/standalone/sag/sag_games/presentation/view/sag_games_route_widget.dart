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
                  state.doesSAGGamePreviewListBecameAvailable(nextState),
          builder: (context, state) {
            if (state.isSAGGamePreviewListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              );
            }
            final sagGamePreviewList = state.sagGamePreviewList!;
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: sagGamePreviewList.length,
              itemBuilder: (context, index) {
                final sagGamePreview = sagGamePreviewList[index];
                return GameCard(
                  gamePreview: sagGamePreview,
                  onTap: () {
                    _bloc(context).add(SelectGameBlocEvent(sagGamePreview));
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
