import 'package:flutter/material.dart';

class GamesColors extends ThemeExtension<GamesColors> {
  GamesColors({
    required this.correct,
    required this.incorrect,
    required this.golden,
  });

  final Color correct;
  final Color incorrect;
  final Color golden;

  @override
  ThemeExtension<GamesColors> copyWith({Color? income, Color? expense}) {
    return GamesColors(
      correct: income ?? this.correct,
      incorrect: expense ?? this.incorrect,
      golden: expense ?? this.golden,
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
