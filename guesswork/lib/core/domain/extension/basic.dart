extension IntUtils on int {
  int rows(int columns) => this ~/ columns;
}

extension BoolUtils on bool {
  int get intValue => this ? 1 : 0;

  int get invIntValue => this ? 0 : 1;
}

extension RatioUtils on double {
  double get oneMinus => 1 - this;

  double get inverse => this == 0 ? 0 : 1 / this;

  int remapped(int min, int max) => ((max - min) * this + min).toInt();
}

extension SetUtils<T> on Set<T> {
  Set<T> get modifiable => Set<T>.from(this);
}
