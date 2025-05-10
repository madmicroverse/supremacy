import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/constants/space.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/extension/localozations.dart';

import '../bloc/sign_in_be.dart';
import '../bloc/sign_in_bloc.dart';

class PlayAsGuestButton extends StatelessWidget {
  const PlayAsGuestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<SignInBloc>().add(AnonymousSignInBE()),
      style: TextButton.styleFrom(
        foregroundColor: context.colorScheme.onPrimary,
        padding: vpMin,
        shape: rrbMid.copyWith(
          side: BorderSide(color: context.colorScheme.onPrimary.withMidAlpha),
        ),
      ),
      child: Text(
        context.loc.sign_in_anonymous_cta,
        style: context.textTheme.bodyLarge
            ?.inverseColor(context)
            .withFontWeight(FontWeight.w600),
      ),
    );
  }
}
