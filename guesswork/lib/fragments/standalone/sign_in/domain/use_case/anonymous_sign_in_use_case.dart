import 'dart:async';

import 'package:guesswork/core/data/framework/firebase/sign_in_with_google.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/auth_repository.dart';

class AnonymousSignInUseCase {
  AuthRepository _accountRepository;

  AnonymousSignInUseCase(this._accountRepository);

  Future<Result<Object, BaseError>> call() async {
    final result = await _accountRepository.signInAnonymously();
    switch (result) {
      case Success():
        // TODO probably remap data entities to domain entities BORING
        // map domain success to presentation success
        return result;
      case Error():
        // TODO map domain error to presentation error
        switch (result.error) {
          case AlreadyAuthenticatedError():
            return result;
        }
        return result;
    }
  }
}
