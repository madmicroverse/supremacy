import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/fragments/standalone/sign_in/presentation/bloc/sign_in_bloc.dart'
    show SignInBlocError;

part 'sign_in_bloc_state.freezed.dart';

enum AuthProvider { google, apple, anonymous, none }

@freezed
abstract class SignInBlocState with _$SignInBlocState {
  const factory SignInBlocState({
    @Default(true) bool isLoading,
    @Default(false) bool isAuthenticated,
    @Default(AuthProvider.none) AuthProvider authProvider,
    String? userId,
    String? displayName,
    String? email,
    String? photoUrl,
    String? errorMessage,
    SignInBlocError? signInBlocError,
  }) = _SignInBlocState;
}

extension SignInBlocStateMutations on SignInBlocState {
  SignInBlocState withSignInBlocError(SignInBlocError signInBlocError) =>
      copyWith(signInBlocError: signInBlocError);

  SignInBlocState errorState(String error) => copyWith(errorMessage: error);

  SignInBlocState get noErrorState => copyWith(errorMessage: null);

  SignInBlocState get loadingState => copyWith(isLoading: true);

  SignInBlocState get idleState => copyWith(isLoading: false);
}

extension SignInBlocStateStateQueries on SignInBlocState {
  bool isLoadingCompleted(SignInBlocState nextState) =>
      isLoading && !nextState.isLoading;

  bool isNewSignInBlocError(SignInBlocState nextState) =>
      signInBlocError != nextState.signInBlocError &&
      nextState.signInBlocError != null;
}
