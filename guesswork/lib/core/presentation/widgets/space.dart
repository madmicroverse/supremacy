import 'package:flutter/cupertino.dart';

extension SpacingUtils on int {
  Widget get vs => SizedBox(height: toDouble());

  Widget get hs => SizedBox(width: toDouble());
}

final vsMin = 12.vs;
final vsMid = 24.vs;
final vsMax = 32.vs;

final hsMin = 12.vs;
final hsMid = 24.vs;
final hsMax = 32.vs;
