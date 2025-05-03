import 'package:guesswork/core/data/framework/firebase/sign_in_anonymously.dart';
import 'package:guesswork/core/data/framework/firebase/sign_in_with_google.dart';
import 'package:guesswork/core/data/framework/firebase/sign_out.dart';
import 'package:guesswork/core/data/framework/firebase/signed_status.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final SignInWithGoogle _signInWithGoogle;
  final SignInAnonymous _signInAnonymously;
  final SignOut _signOut;
  final SignedStatus _signedStatus;

  AuthRepositoryImpl(
    this._signInWithGoogle,
    this._signInAnonymously,
    this._signOut,
    this._signedStatus,
  );

  @override
  Future<Result<bool, BaseError>> signInWithGoogle() => _signInWithGoogle();

  @override
  Future<Result<bool, BaseError>> signInAnonymously() => _signInAnonymously();

  @override
  Future<void> signOut() => _signOut();

  @override
  Result<AuthStatus, BaseError> getAuthStatus() => _signedStatus();
}
