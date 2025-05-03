import 'dart:math';
import 'dart:ui';

Color randomColor() {
  Random random = Random();
  return Color.fromARGB(
    255, // Alpha (opacity)
    random.nextInt(256), // Red
    random.nextInt(256), // Green
    random.nextInt(256), // Blue
  );
}

List<Color> devColors = List.generate(100, (index) => randomColor());
