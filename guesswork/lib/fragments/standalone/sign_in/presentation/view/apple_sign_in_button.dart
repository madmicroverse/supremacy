import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/extension/localozations.dart';
import 'package:guesswork/core/presentation/widgets/space.dart';

import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_bloc_events.dart';

const buttonIconSize = 26.0;

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<SignInBloc>().add(AppleSignInBlocEvent()),
      style: context.elevatedButtonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.apple, size: buttonIconSize),
          hsMin,
          Text(
            context.loc.sign_in_apple_cta,
            style: context.textTheme.bodyLarge?.withFontWeight(FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
