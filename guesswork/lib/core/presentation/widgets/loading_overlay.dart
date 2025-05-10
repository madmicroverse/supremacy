import 'package:flutter/material.dart';
import 'package:guesswork/core/domain/constants/space.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';

const loadingStrokeWidth = 7.0;

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.scrim.withMaxAlpha,
      child: Center(
        child: Container(
          padding: pMid,
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimary.withMidAlpha,
            borderRadius: brMin,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                strokeWidth: loadingStrokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(
                  context.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
