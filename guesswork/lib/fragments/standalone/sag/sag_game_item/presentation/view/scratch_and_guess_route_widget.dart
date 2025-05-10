import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/constants/space.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/extension/localozations.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game_item/presentation/bloc/sag_game_item_be.dart';
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
    return BlocConsumer<SAGGameItemBloc, SAGGameItemBS>(
      listenWhen:
          (state, nextState) => state.isNewSAGGameItemViewError(nextState),
      listener:
          (context, state) => handleError(context, state.sagGameItemViewError),
      buildWhen:
          (state, nextState) => state.doesGamesImageBecameAvailable(nextState),
      builder: (context, state) {
        return Scaffold(
          appBar: ScratchAndGuessAppBar(
            sagGameItemBS: state,
            settingsButton: settingsButton,
            noAdsButton: noAdsButton,
          ),
          body: Builder(
            builder: (context) {
              if (!state.isGamesImageAvailable) {
                return Center(child: CircularProgressIndicator());
              }
              return Stack(
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
                            color: context.colorScheme.surfaceContainerHighest,
                            child: Center(child: Text("ad space")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CompleteEffects(),
                ],
              );
            },
          ),
        );
      },
    );
  }

  static void handleError(
    BuildContext context,
    SAGGameItemViewError? sagGameItemViewError,
  ) {
    switch (sagGameItemViewError) {
      case null:
      case SAGGameItemViewUrlError():
        context.showErrorSnackBar(
          context.loc.system_error,
          duration: ContextWidgetBuilder.maxDuration,
          snackBarAction: SnackBarAction(
            label: context.loc.system_error_back_cta,
            onPressed: () => context.addEvent(PopAfterUnknownErrorBE()),
          ),
        );
      case SAGGameItemViewConnectionError():
        context.showErrorSnackBar(
          context.loc.no_internet_error,
          duration: ContextWidgetBuilder.maxDuration,
          snackBarAction: SnackBarAction(
            label: context.loc.internet_error_cta,
            onPressed:
                () => context.addEvent(
                  InitGamesImageBE(
                    context.bloc.state.sagGameItem!.guessImageUrl,
                  ),
                ),
          ),
        );
    }
  }
}
