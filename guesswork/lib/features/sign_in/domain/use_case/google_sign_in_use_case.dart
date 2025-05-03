import 'dart:async';
import 'dart:math';

import 'package:guesswork/core/domain/entity/result.dart';

class GoogleSignInUseCase {
  GoogleSignInUseCase();

  Future<Result<Object, BaseError>> call() async {
    // For now, just simulate successful login
    await Future.delayed(const Duration(seconds: 2));

    if (Random().nextDouble() < 0.5) {
      return Success("SUCCESS");
    } else {
      return Error(TimeoutError());
    }
  }
}
