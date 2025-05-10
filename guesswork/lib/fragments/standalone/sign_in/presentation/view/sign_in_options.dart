import 'package:flutter/material.dart';
import 'package:guesswork/core/domain/constants/space.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/extension/localozations.dart';
import 'package:guesswork/fragments/standalone/sign_in/presentation/view/sign_in_divider.dart';

import '../bloc/sign_in_bloc_state.dart';
import 'apple_sign_in_button.dart';
import 'google_sign_in_button.dart';
import 'play_as_guest_button.dart';

class SignInOptions extends StatelessWidget {
  final SignInBlocState state;

  const SignInOptions({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: pMid,
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary.withMidAlpha,
        borderRadius: brMid,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.loc.sign_in_cta,
            textAlign: TextAlign.center,
            style: context.textTheme.displaySmall?.inverseColor(context),
          ),
          vsMin,
          Text(
            context.loc.sign_in_cta_method,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.inverseColor(context),
          ),
          vsMax,
          const GoogleSignInButton(),
          vsMid,
          const AppleSignInButton(),
          vsMax,
          const SignInDivider(),
          vsMax,
          const PlayAsGuestButton(),
        ],
      ),
    );
  }
}
