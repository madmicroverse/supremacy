import 'dart:async';

import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/auth_repository.dart';

sealed class AnonymousSignInUseCaseError extends BaseError {}

class AnonymousSignInUseCaseConnectionError
    extends AnonymousSignInUseCaseError {}

class AnonymousSignInUseCaseUnknownError extends AnonymousSignInUseCaseError {}

class AnonymousSignInUseCase {
  final AuthRepository _accountRepository;

  const AnonymousSignInUseCase(this._accountRepository);

  Future<Result<void, AnonymousSignInUseCaseError>> call() async {
    final result = await _accountRepository.signInAnonymously();
    switch (result) {
      case Success():
        return Success(result.data);
      case Error():
        final error = result.error;
        switch (error) {
          case SignInAnonymouslyDataAccessError():
            return Error(AnonymousSignInUseCaseConnectionError());
          case SignInAnonymouslyUnknownError():
            return Error(AnonymousSignInUseCaseUnknownError());
        }
    }
  }
}
