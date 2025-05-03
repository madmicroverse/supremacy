import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _SignInBlocState;
}

extension SignInBlocStateStateUtils on SignInBlocState {
  bool isLoadingCompleted(SignInBlocState nextState) =>
      isLoading && !nextState.isLoading;

  SignInBlocState errorState(String error) => copyWith(errorMessage: error);

  SignInBlocState get noErrorState => copyWith(errorMessage: null);

  SignInBlocState get loadingState => copyWith(isLoading: true);

  SignInBlocState get idleState => copyWith(isLoading: false);
}
