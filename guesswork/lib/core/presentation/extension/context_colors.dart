import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:guesswork/core/presentation/color_extra.dart';

extension ContextWidgetBuilder on BuildContext {
  Divider get divider => Divider(color: colorScheme.onPrimary, thickness: 1);
  static final maxDuration = Duration(days: 3);

  void showErrorSnackBar(
    String errorMessage, {
    Duration? duration,
    SnackBarAction? snackBarAction,
  }) => ScaffoldMessenger.of(this).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      action: snackBarAction,
      duration: duration ?? 4000.ms,
      backgroundColor: gamesColors.incorrect,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

extension ContextStyleQueries on BuildContext {
  GamesColors get gamesColors => Theme.of(this).extension<GamesColors>()!;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ButtonStyle get elevatedButtonStyle =>
      Theme.of(this).elevatedButtonTheme.style!;
}

extension TextStyleMutations on TextStyle {
  TextStyle inverseColor(BuildContext context) =>
      copyWith(color: context.colorScheme.onPrimary);

  TextStyle withFontWeight(FontWeight fontWeight) =>
      copyWith(fontWeight: fontWeight);
}

extension ColorMutations on Color {
  Color get withMinAlpha => withAlpha(25);

  Color get withMidAlpha => withAlpha(50);

  Color get withMaxAlpha => withAlpha(100);
}
