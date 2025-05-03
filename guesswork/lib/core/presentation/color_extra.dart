import 'package:flutter/material.dart';

class ColorExtra extends ThemeExtension<ColorExtra> {
  ColorExtra({
    required this.income,
    required this.expense,
  });

  final Color income;
  final Color expense;

  @override
  ThemeExtension<ColorExtra> copyWith({
    Color? income,
    Color? expense,
  }) {
    return ColorExtra(
      income: income ?? this.income,
      expense: expense ?? this.expense,
    );
  }

  @override
  ThemeExtension<ColorExtra> lerp(
      covariant ThemeExtension<ColorExtra>? other, double t) {
    if (other is ColorExtra) {
      return this;
    }
    return this;
  }
}
