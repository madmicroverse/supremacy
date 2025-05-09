import 'package:flutter/material.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/extension/localozations.dart';

class SignInDivider extends StatelessWidget {
  const SignInDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: context.divider),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            context.loc.sign_in_or,
            style: context.textTheme.labelLarge?.inverseColor(context),
          ),
        ),
        Expanded(child: context.divider),
      ],
    );
  }
}
