import 'dart:ui';

import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

extension OffsetMap on Offset {
  PathPoint get toPathPoint => PathPoint(x: dx, y: dy);
}

extension SetOffsetMap on Set<Offset> {
  List<PathPoint> get toPathPointList =>
      map((offset) => offset.toPathPoint).toList();
}
