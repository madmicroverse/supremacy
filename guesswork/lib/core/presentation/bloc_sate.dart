import 'package:freezed_annotation/freezed_annotation.dart';

part 'bloc_sate.freezed.dart';

sealed class StateStatus {}

class LoadingStateStatus extends StateStatus {}

class ErrorStateStatus extends StateStatus {
  String error;

  ErrorStateStatus(this.error);
}

class IdleStateStatus extends StateStatus {}

class InitStateStatus extends StateStatus {}

@Freezed(genericArgumentFactories: true)
abstract class BlocState<C> with _$BlocState<C> {
  const BlocState._();

  const factory BlocState({required StateStatus status, required C content}) =
      _BlocState;

  bool isInitCompleted(BlocState nextState) =>
      status is LoadingStateStatus && nextState.status is! LoadingStateStatus;

  BlocState<C> get initState => copyWith(status: InitStateStatus());

  bool get isInit => status is InitStateStatus;

  bool isLoadingCompleted(BlocState nextState) =>
      status is LoadingStateStatus && nextState.status is! LoadingStateStatus;

  BlocState<C> get loadingState => copyWith(status: LoadingStateStatus());

  bool get isLoading => status is LoadingStateStatus;

  BlocState<C> get idleState => copyWith(status: IdleStateStatus());

  bool get isIdle => status is LoadingStateStatus;

  BlocState<C> errorState(String error) =>
      copyWith(status: ErrorStateStatus(error));

  bool get isError => status is ErrorStateStatus;
}
