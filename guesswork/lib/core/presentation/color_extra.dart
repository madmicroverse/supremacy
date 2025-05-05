import 'package:flutter/material.dart';

class GamesColors extends ThemeExtension<GamesColors> {
  GamesColors({required this.correct, required this.incorrect});

  final Color correct;
  final Color incorrect;

  @override
  ThemeExtension<GamesColors> copyWith({Color? income, Color? expense}) {
    return GamesColors(
      correct: income ?? this.correct,
      incorrect: expense ?? this.incorrect,
    );
  }

  @override
  ThemeExtension<GamesColors> lerp(
    covariant ThemeExtension<GamesColors>? other,
    double t,
  ) {
    if (other is GamesColors) {
      return this;
    }
    return this;
  }
}
