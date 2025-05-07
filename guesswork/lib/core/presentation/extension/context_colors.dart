import 'package:flutter/material.dart';
import 'package:guesswork/core/presentation/color_extra.dart';

extension ContextColors on BuildContext {
  GamesColors get gamesColors => Theme.of(this).extension<GamesColors>()!;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
