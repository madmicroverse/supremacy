import 'package:flutter/cupertino.dart';

const matrixRowA = <double>[0.2126, 0.7152, 0.0722, 0, 0];
const matrixRowB = <double>[0, 0, 0, 1, 0];

class Greyscale extends StatelessWidget {
  final Widget child;

  const Greyscale({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        ...matrixRowA,
        ...matrixRowA,
        ...matrixRowA,
        ...matrixRowB,
      ]),
      child: child,
    );
  }
}
