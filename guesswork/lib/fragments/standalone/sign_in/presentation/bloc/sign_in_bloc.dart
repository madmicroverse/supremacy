import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/di/modules/router_module.dart';

import '../../domain/use_case/anonymous_sign_in_use_case.dart';
import '../../domain/use_case/apple_sign_in_use_case.dart';
import '../../domain/use_case/google_sign_in_use_case.dart';
import 'sign_in_be.dart';
import 'sign_in_bloc_state.dart';

class SignInBloc extends Bloc<SignInBE, SignInBlocState> {
  final IRouter _router;

  final GoogleSignInUseCase _googleSignInUseCase;
  final AppleSignInUseCase _appleSignInUseCase;
  final AnonymousSignInUseCase _anonymousSignInUseCase;

  SignInBloc(
    this._router,
    this._googleSignInUseCase,
    this._appleSignInUseCase,
    this._anonymousSignInUseCase,
  ) : super(SignInBlocState()) {
    on<InitSignInBE>(_initSignInBE);
    on<PopSignInBE>(_popSignInBE);
    on<GoogleSignInBE>(_googleSignInBE);
    on<AppleSignInBE>(_appleSignInBE);
    on<AnonymousSignInBE>(_anonymousSignInBE);
  }

  FutureOr<void> _initSignInBE(
    InitSignInBE event,
    Emitter<SignInBlocState> emit,
  ) async {
    emit(state.loadingState);
    await Future.delayed(2000.ms);
    emit(state.idleState);
  }

  FutureOr<void> _popSignInBE(
    PopSignInBE event,
    Emitter<SignInBlocState> emit,
  ) async {
    _router.pop();
  }

  FutureOr<void> _googleSignInBE(
    GoogleSignInBE event,
    Emitter<SignInBlocState> emit,
  ) async {
    emit(state.loadingState.noErrorState);
    final result = await _googleSignInUseCase();
    switch (result) {
      case Success():
        _router.goNamed(sagGamesMainRouteName);
      case Error():
        emit(state.idleState.errorState(result.error.runtimeType.toString()));
    }
  }

  FutureOr<void> _appleSignInBE(
    AppleSignInBE event,
    Emitter<SignInBlocState> emit,
  ) async {
    emit(state.loadingState.noErrorState);
    final result = await _appleSignInUseCase();
    switch (result) {
      case Success():
        _router.goNamed(sagGamesMainRouteName);
      case Error():
        emit(state.idleState.errorState(result.error.runtimeType.toString()));
    }
  }

  FutureOr<void> _anonymousSignInBE(
    AnonymousSignInBE event,
    Emitter<SignInBlocState> emit,
  ) async {
    emit(state.loadingState.noErrorState);
    final result = await _anonymousSignInUseCase();
    switch (result) {
      case Success():
        _router.goNamed(sagGamesMainRouteName);
      case Error():
        final error = result.error;
        switch (error) {
          case AnonymousSignInUseCaseConnectionError():
            emit(
              state.idleState.withSignInBlocError(
                AnonymousSignInConnectionError(),
              ),
            );
          case AnonymousSignInUseCaseUnknownError():
            emit(
              state.idleState.withSignInBlocError(
                AnonymousSignInUnknownError(),
              ),
            );
        }
    }
  }
}
