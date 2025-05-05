import "package:flutter/material.dart";
import "package:guesswork/core/presentation/color_extra.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4279723396),
      surfaceTint: Color(4279723396),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4290898175),
      onPrimaryContainer: Color(4278197803),
      secondary: Color(4283261292),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4291880691),
      onSecondaryContainer: Color(4278787623),
      tertiary: Color(4284439165),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4293254911),
      onTertiaryContainer: Color(4279965494),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294376190),
      onBackground: Color(4279704607),
      surface: Color(4294376190),
      onSurface: Color(4279704607),
      surfaceVariant: Color(4292666345),
      onSurfaceVariant: Color(4282402892),
      outline: Color(4285626493),
      outlineVariant: Color(4290824141),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086260),
      inverseOnSurface: Color(4293784053),
      inversePrimary: Color(4287483889),
      primaryFixed: Color(4290898175),
      onPrimaryFixed: Color(4278197803),
      primaryFixedDim: Color(4287483889),
      onPrimaryFixedVariant: Color(4278209894),
      secondaryFixed: Color(4291880691),
      onSecondaryFixed: Color(4278787623),
      secondaryFixedDim: Color(4290104023),
      onSecondaryFixedVariant: Color(4281747796),
      tertiaryFixed: Color(4293254911),
      onTertiaryFixed: Color(4279965494),
      tertiaryFixedDim: Color(4291347178),
      onTertiaryFixedVariant: Color(4282860388),
      surfaceDim: Color(4292270814),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293586674),
      surfaceContainerHigh: Color(4293257709),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278208609),
      surfaceTint: Color(4279723396),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281760923),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281484624),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284708739),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282597216),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285886612),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294376190),
      onBackground: Color(4279704607),
      surface: Color(4294376190),
      onSurface: Color(4279704607),
      surfaceVariant: Color(4292666345),
      onSurfaceVariant: Color(4282139720),
      outline: Color(4284047461),
      outlineVariant: Color(4285824129),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086260),
      inverseOnSurface: Color(4293784053),
      inversePrimary: Color(4287483889),
      primaryFixed: Color(4281760923),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4279460737),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284708739),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283129706),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4285886612),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4284242042),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292270814),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293586674),
      surfaceContainerHigh: Color(4293257709),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278199860),
      surfaceTint: Color(4279723396),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278208609),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279248174),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281484624),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280426045),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282597216),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294376190),
      onBackground: Color(4279704607),
      surface: Color(4294376190),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4292666345),
      onSurfaceVariant: Color(4280165673),
      outline: Color(4282139720),
      outlineVariant: Color(4282139720),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086260),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4292342015),
      primaryFixed: Color(4278208609),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278202691),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281484624),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280037177),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282597216),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281149768),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292270814),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293586674),
      surfaceContainerHigh: Color(4293257709),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4287483889),
      surfaceTint: Color(4287483889),
      onPrimary: Color(4278203720),
      primaryContainer: Color(4278209894),
      onPrimaryContainer: Color(4290898175),
      secondary: Color(4290104023),
      onSecondary: Color(4280234813),
      secondaryContainer: Color(4281747796),
      onSecondaryContainer: Color(4291880691),
      tertiary: Color(4291347178),
      onTertiary: Color(4281347148),
      tertiaryContainer: Color(4282860388),
      onTertiaryContainer: Color(4293254911),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279178263),
      onBackground: Color(4292862951),
      surface: Color(4279178263),
      onSurface: Color(4292862951),
      surfaceVariant: Color(4282402892),
      onSurfaceVariant: Color(4290824141),
      outline: Color(4287271575),
      outlineVariant: Color(4282402892),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inverseOnSurface: Color(4281086260),
      inversePrimary: Color(4279723396),
      primaryFixed: Color(4290898175),
      onPrimaryFixed: Color(4278197803),
      primaryFixedDim: Color(4287483889),
      onPrimaryFixedVariant: Color(4278209894),
      secondaryFixed: Color(4291880691),
      onSecondaryFixed: Color(4278787623),
      secondaryFixedDim: Color(4290104023),
      onSecondaryFixedVariant: Color(4281747796),
      tertiaryFixed: Color(4293254911),
      onTertiaryFixed: Color(4279965494),
      tertiaryFixedDim: Color(4291347178),
      onTertiaryFixedVariant: Color(4282860388),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279704607),
      surfaceContainer: Color(4279967779),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4287747062),
      surfaceTint: Color(4287483889),
      onPrimary: Color(4278196516),
      primaryContainer: Color(4283865529),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290367195),
      onSecondary: Color(4278458658),
      secondaryContainer: Color(4286551200),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4291610350),
      onTertiary: Color(4279636528),
      tertiaryContainer: Color(4287794354),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279178263),
      onBackground: Color(4292862951),
      surface: Color(4279178263),
      onSurface: Color(4294441983),
      surfaceVariant: Color(4282402892),
      onSurfaceVariant: Color(4291087569),
      outline: Color(4288455849),
      outlineVariant: Color(4286416009),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inverseOnSurface: Color(4280691502),
      inversePrimary: Color(4278210152),
      primaryFixed: Color(4290898175),
      onPrimaryFixed: Color(4278194973),
      primaryFixedDim: Color(4287483889),
      onPrimaryFixedVariant: Color(4278205264),
      secondaryFixed: Color(4291880691),
      onSecondaryFixed: Color(4278194973),
      secondaryFixedDim: Color(4290104023),
      onSecondaryFixedVariant: Color(4280629571),
      tertiaryFixed: Color(4293254911),
      onTertiaryFixed: Color(4279307307),
      tertiaryFixedDim: Color(4291347178),
      onTertiaryFixedVariant: Color(4281741906),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279704607),
      surfaceContainer: Color(4279967779),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294441983),
      surfaceTint: Color(4287483889),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4287747062),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294441983),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290367195),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294900223),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4291610350),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279178263),
      onBackground: Color(4292862951),
      surface: Color(4279178263),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282402892),
      onSurfaceVariant: Color(4294441983),
      outline: Color(4291087569),
      outlineVariant: Color(4291087569),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4278201919),
      primaryFixed: Color(4291554559),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4287747062),
      onPrimaryFixedVariant: Color(4278196516),
      secondaryFixed: Color(4292209399),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290367195),
      onSecondaryFixedVariant: Color(4278458658),
      tertiaryFixed: Color(4293518335),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4291610350),
      onTertiaryFixedVariant: Color(4279636528),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279704607),
      surfaceContainer: Color(4279967779),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    extensions: <ThemeExtension<dynamic>>[
      GamesColors(
        correct: Color(0xFF86AB89),
        incorrect: Color.fromARGB(255, 231, 155, 152),
      ),
    ],
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      surfaceTint: surfaceTint,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
      primaryFixed: primaryFixed,
      onPrimaryFixed: onPrimaryFixed,
      primaryFixedDim: primaryFixedDim,
      onPrimaryFixedVariant: onPrimaryFixedVariant,
      secondaryFixed: secondaryFixed,
      onSecondaryFixed: onSecondaryFixed,
      secondaryFixedDim: secondaryFixedDim,
      onSecondaryFixedVariant: onSecondaryFixedVariant,
      tertiaryFixed: tertiaryFixed,
      onTertiaryFixed: onTertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim,
      onTertiaryFixedVariant: onTertiaryFixedVariant,
      surfaceDim: surfaceDim,
      surfaceBright: surfaceBright,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
