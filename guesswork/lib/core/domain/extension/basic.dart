extension IntUtils on int {
  int rows(int columns) => this ~/ columns;
}

extension BoolUtils on bool {
  int get intValue => this ? 1 : 0;

  int get invIntValue => this ? 0 : 1;
}

extension RatioUtils on double? {
  double get oneMinus => 1 - orZero;

  double get inverse => this == 0 ? 0 : 1 / orOne;

  double get orOne => this ?? 1;

  double get orZero => this ?? 0;

  int remapped(int min, int max) => ((max - min) * orOne + min).toInt();
}

extension SetUtils<T> on Set<T> {
  Set<T> get modifiable => Set<T>.from(this);
}

extension StringUtils on String?{
  String get orEmpty => this??'';
}