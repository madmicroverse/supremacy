import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/data/framework/firebase/sign_in_anonymously.dart';
import 'package:guesswork/core/data/framework/firebase/sign_in_with_google.dart';
import 'package:guesswork/core/data/repository/auth_repository_impl.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../domain/use_case/anonymous_sign_in_use_case.dart';
import '../domain/use_case/apple_sign_in_use_case.dart';
import '../domain/use_case/google_sign_in_use_case.dart';
import '../presentation/bloc/sign_in_bloc.dart';
import '../presentation/bloc/sign_in_bloc_events.dart';
import '../presentation/view/sign_in_route_widget.dart';

const sign_inWidget = "sign_inRouteWidget";

@module
abstract class SignInModule {
  @injectable
  GoogleSignInUseCase get googleSignInUseCase => GoogleSignInUseCase();

  @injectable
  AppleSignInUseCase get appleSignInUseCase => AppleSignInUseCase();




  @injectable
  AnonymousSignInUseCase anonymousSignInUseCase(
    AuthRepository authRepository,
  ) => AnonymousSignInUseCase(authRepository);

  @Injectable()
  SignInBloc signInBlocFactory(
    IRouter router,
    GoogleSignInUseCase googleSignInUseCase,
    AppleSignInUseCase appleSignInUseCase,
    AnonymousSignInUseCase anonymousSignInUseCase,
  ) {
    return SignInBloc(
      router,
      googleSignInUseCase,
      appleSignInUseCase,
      anonymousSignInUseCase,
    );
  }

  @Named(sign_inWidget)
  @Injectable()
  Widget signInRouteWidgetFactory(SignInBloc bloc) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitSignInBlocEvent()),
      child: const SignInRouteWidget(),
    );
  }
}
