import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/extension/localozations.dart';
import 'package:guesswork/core/presentation/widgets/space.dart';

import '../../../../../core/presentation/widgets/loading_overlay.dart';
import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_bloc_state.dart';
import 'sign_in_options.dart';

const logoSize = 150.0;

class SignInRouteWidget extends StatelessWidget {
  const SignInRouteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInBlocState>(
      listenWhen: (state, nextState) => state.isNewSignInBlocError(nextState),
      listener: (context, state) => handleError(context, state.signInViewError),
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.colorScheme.primary.withAlpha(230),
                  context.colorScheme.primary.withAlpha(150),
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.hive,
                            color: context.colorScheme.onPrimary,
                            size: logoSize,
                          ),
                          vsMax,
                          vsMax,
                          SignInOptions(state: state),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.isLoading) const LoadingOverlay(),
              ],
            ),
          ),
        );
      },
    );
  }

  static void handleError(
    BuildContext context,
    SignInViewError? signInViewError,
  ) {
    switch (signInViewError) {
      case null:
      case AnonymousSignInConnectionError():
      case AnonymousSignInUnknownError():
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _signInViewErrorToLocalization(context, signInViewError!),
            ),
            backgroundColor: context.gamesColors.incorrect,
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  static String _signInViewErrorToLocalization(
    BuildContext context,
    SignInViewError signInViewError,
  ) {
    switch (signInViewError) {
      case AnonymousSignInConnectionError():
        return context.loc.sign_in_anonymous_con_error;
      case AnonymousSignInUnknownError():
        return context.loc.sign_in_anonymous_unknown_error(
          "APP_NAME",
        ); // TODO integrate remote configs please
    }
  }
}
