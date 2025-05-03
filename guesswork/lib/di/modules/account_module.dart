import 'package:firebase_auth/firebase_auth.dart';
import 'package:guesswork/core/data/framework/firebase/firestore_framework.dart';
import 'package:guesswork/core/data/framework/firebase/sign_in_anonymously.dart';
import 'package:guesswork/core/data/framework/firebase/sign_in_with_google.dart';
import 'package:guesswork/core/data/framework/firebase/sign_out.dart';
import 'package:guesswork/core/data/framework/firebase/signed_status.dart';
import 'package:guesswork/core/data/framework/firebase/user_framework.dart';
import 'package:guesswork/core/data/repository/account_repository_impl.dart';
import 'package:guesswork/core/data/repository/auth_repository_impl.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/core/domain/repository/auth_repository.dart';
import 'package:guesswork/core/domain/use_case/get_game_settings_use_case.dart';
import 'package:guesswork/core/domain/use_case/get_game_user_info_use_case.dart';
import 'package:guesswork/core/domain/use_case/set_game_settings_use_case.dart';
import 'package:guesswork/core/domain/use_case/sign_out_use_case.dart';
import 'package:injectable/injectable.dart';

const emulated = bool.fromEnvironment('emulated', defaultValue: false);

@module
abstract class AccountModule {
  @Singleton()
  UserFramework userFrameworkFactory(FirebaseAuth firebaseAuth) {
    return UserFramework(firebaseAuth);
  }

  @Injectable()
  AccountRepository accountRepositoryFactory(
    UserFramework userFramework,
    FirestoreFramework firestoreFramework,
  ) {
    return AccountRepositoryImpl(userFramework, firestoreFramework);
  }

  @Injectable()
  GetGamesSettingsUseCase getGamesSettingsUseCaseFactory(
    AccountRepository accountRepository,
  ) {
    return GetGamesSettingsUseCase(accountRepository);
  }

  @Injectable()
  SetGamesSettingsUseCase setGamesSettingsUseCaseFactory(
    AccountRepository accountRepository,
  ) {
    return SetGamesSettingsUseCase(accountRepository);
  }

  @Injectable()
  GetGamesUserInfoUseCase getGamesUserInfoUseCaseFactory(
    AccountRepository accountRepository,
  ) {
    return GetGamesUserInfoUseCase(accountRepository);
  }

  @Singleton()
  SignInWithGoogle signInWithGoogleFactory(FirebaseAuth firebaseAuth) {
    return SignInWithGoogle(firebaseAuth);
  }

  @Singleton()
  SignInAnonymous signInAnonymousFactory(FirebaseAuth firebaseAuth) {
    return SignInAnonymous(firebaseAuth);
  }

  @Singleton()
  SignOut signOutFactory(FirebaseAuth firebaseAuth) {
    return SignOut(firebaseAuth);
  }

  @Singleton()
  SignedStatus signedStatusFactory(FirebaseAuth firebaseAuth) {
    return SignedStatus(firebaseAuth);
  }

  @Injectable()
  AuthRepository authRepositoryFactory(
    SignInWithGoogle signInWithGoogle,
    SignInAnonymous signInAnonymous,
    SignOut signOut,
    SignedStatus signedStatus,
  ) {
    return AuthRepositoryImpl(
      signInWithGoogle,
      signInAnonymous,
      signOut,
      signedStatus,
    );
  }

  @Injectable()
  SignOutUseCase signOutUseCaseFactory(AuthRepository authRepository) {
    return SignOutUseCase(authRepository);
  }
}
