import 'dart:ui';

extension OffsetUtils on Offset {
  Map<String, double> toJson() => {'x': dx, 'y': dy};
}

extension OffsetListUtils on Set<Offset> {
  List<Map<String, double>> toJson() =>
      map((offset) => offset.toJson()).toList();
}
