import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/extension/localozations.dart';
import 'package:guesswork/core/presentation/widgets/backgound_widget.dart';

import '../bloc/sag_games_be.dart';
import '../bloc/sag_games_bloc.dart';
import '../bloc/sag_games_bsc.dart';
import 'game_card.dart';

extension ContextBloc on BuildContext {
  SAGGamesBloc get bloc => read<SAGGamesBloc>();

  addEvent(SAGGamesBE event) => bloc.add(event);
}

class SAGGamesRouteWidget extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget Function(SAGGame sagGame) sagGameSelectionButtonProvider;

  const SAGGamesRouteWidget({
    super.key,
    required this.appBar,
    required this.sagGameSelectionButtonProvider,
  });

  SAGGamesBloc _bloc(BuildContext context) => context.read<SAGGamesBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: BackgroundWidget(
        child: BlocConsumer<SAGGamesBloc, SAGGamesBSC>(
          listenWhen:
              (state, nextState) => state.isSAGGamesBSCViewError(nextState),
          listener:
              (context, state) => handleError(context, state.sagGamesBSCError),
          buildWhen:
              (state, nextState) =>
                  state.doesSAGGameListBecameAvailable(nextState) ||
                  state.doesSAGGameListWasUpdated(nextState),
          builder: (context, state) {
            if (state.isSAGGameListLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: context.colorScheme.primary,
                  strokeWidth: 3,
                ),
              );
            }
            final sagGameList = state.sagGameList!;
            final grid = GridView.builder(
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
                  selectionButton: sagGameSelectionButtonProvider(sagGame),
                  onTap: () {
                    _bloc(context).add(SelectGameBlocEvent(sagGame));
                  },
                );
              },
            );

            if (state.isSAGGamesRefreshable) {
              return CustomMaterialIndicator(
                onRefresh: () async {
                  final completer = Completer();
                  context.addEvent(PullToRefreshBlocEvent(completer));
                  await completer.future;
                },
                child: grid,
              );
            }

            return grid;
          },
        ),
      ),
    );
  }

  static void handleError(
    BuildContext context,
    SAGGamesBSCViewError? sagGamesBSCError,
  ) {
    switch (sagGamesBSCError) {
      case null:
      case SAGGamesBSCUnknownError():
        context.showErrorSnackBar(
          _sagGamesBSCErrorToLocalization(context, sagGamesBSCError!),
        );
    }
  }

  static String _sagGamesBSCErrorToLocalization(
    BuildContext context,
    SAGGamesBSCViewError sagGamesBSCError,
  ) {
    switch (sagGamesBSCError) {
      case SAGGamesBSCUnknownError():
        return context.loc.system_error;
    }
  }
}
