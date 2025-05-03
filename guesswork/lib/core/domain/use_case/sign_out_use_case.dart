import 'dart:async';

import 'package:guesswork/core/domain/repository/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  Future<void> call() async => await _authRepository.signOut();
}
