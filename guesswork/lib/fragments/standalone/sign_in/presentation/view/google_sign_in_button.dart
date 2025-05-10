import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/constants/resources.dart';
import 'package:guesswork/core/domain/constants/space.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/extension/localozations.dart';

import '../bloc/sign_in_be.dart';
import '../bloc/sign_in_bloc.dart';

const buttonIconSize = 20.0;

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<SignInBloc>().add(GoogleSignInBE()),
      style: context.elevatedButtonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: ImageAsset.googleSignIn.source,
            height: buttonIconSize,
            width: buttonIconSize,
          ),
          hsMin,
          Text(
            context.loc.sign_in_google_cta,
            style: context.textTheme.bodyLarge?.withFontWeight(FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
