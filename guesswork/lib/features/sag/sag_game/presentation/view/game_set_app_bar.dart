import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';

import '../bloc/sag_game_bloc.dart';
import '../bloc/sag_game_bsc.dart';

class GameSetBlocAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AudioPlayer partyPopperPlayer;

  GameSetBlocAppBar({super.key}) : partyPopperPlayer = AudioPlayer() {
    partyPopperPlayer.setVolume(0.25);
    partyPopperPlayer.setReleaseMode(ReleaseMode.release);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await partyPopperPlayer.setSource(
        AssetSource('sounds/coins_dropping.mp3'),
      );
      // await player.resume();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SAGGameBloc, BlocState<SAGGameBSC>>(
      listenWhen:
          (state, nextState) =>
              state.content.userPointsUpdated(nextState.content),
      listener: (BuildContext context, BlocState<SAGGameBSC> state) {
        partyPopperPlayer.resume();
      },
      buildWhen:
          (state, nextState) =>
              state.isLoadingCompleted(nextState) ||
              state.content.userPointsUpdated(nextState.content),
      builder: (context, state) {
        if (state.isLoading) {
          return Container();
        }

        final gameSet = state.content.gameSet!;

        return AppBar(
          title: Text(gameSet.title),
          automaticallyImplyLeading: true,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                height: kToolbarHeight - 20,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/coins.webp',
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(width: 10),
                    AnimatedFlipCounter(
                      value: state.content.userPoints,
                      duration: Duration(seconds: 3),
                      wholeDigits: 8,
                      hideLeadingZeroes: true,
                      textStyle: TextStyle(color: Colors.amber, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
