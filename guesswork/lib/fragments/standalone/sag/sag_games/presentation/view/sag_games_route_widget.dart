import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';
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
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   title: const Text(
      //     'Scratch & Guess Games',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 24,
      //       color: Colors.white,
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.settings, size: 28),
      //       onPressed: () {},
      //       tooltip: 'Logout',
      //     ),
      //     IconButton(
      //       icon: const NoAdIconWidget(size: 28),
      //       onPressed: () {
      //         _bloc(context).add(SignOutBlocEvent());
      //       },
      //       tooltip: 'Logout',
      //     ),
      //   ],
      // ),
      body: BackgroundWidget(
        child: BlocBuilder<SAGGamesBloc, BlocState<SAGGamesBSC>>(
          buildWhen: (state, nextState) => state.isLoadingCompleted(nextState),
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              );
            }

            List<SAGGamePreview> sagGamePreviewList =
                state.content.sagGamePreviewList!;

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
