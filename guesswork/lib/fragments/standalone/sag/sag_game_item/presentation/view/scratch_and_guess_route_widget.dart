import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/widgets/space.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game_item/presentation/view/bloc_utils.dart';

import '../bloc/sag_game_item_bloc.dart';
import '../bloc/sag_game_item_bs.dart';
import 'completed_effects.dart';
import 'guess_options.dart';
import 'scratch_and_guess_app_bar.dart';
import 'scratch_section.dart';

class SAGGameItemRouteWidget extends StatelessWidget {
  final Widget settingsButton;
  final Widget noAdsButton;

  const SAGGameItemRouteWidget({
    super.key,
    required this.settingsButton,
    required this.noAdsButton,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SAGGameItemBloc, SAGGameItemBS>(
      buildWhen:
          (state, nextState) => state.doesGamesImageBecameAvailable(nextState),
      builder: (context, state) {
        // return ConfettiSample();

        if (!state.isGamesImageAvailable) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: ScratchAndGuessAppBar(
            sagGameItemBS: state,
            settingsButton: settingsButton,
            noAdsButton: noAdsButton,
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: ScratchSection(sagGameItemBS: state),
                    ),
                    GuessOptions(),
                    vsMid,
                    InkWell(
                      onTap: () {
                        context.confettiController.play();
                      },
                      child: Container(
                        height: 40,
                        color: Colors.grey,
                        child: Center(child: Text("ad space")),
                      ),
                    ),
                  ],
                ),
              ),
              CompleteEffects(),
            ],
          ),
        );
      },
    );
  }
}
