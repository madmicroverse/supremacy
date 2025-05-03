import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmpl_bloc_state.freezed.dart';

@freezed
abstract class TmplBlocState with _$TmplBlocState {
  const factory TmplBlocState({@Default(true) bool isLoading}) = _TmplBlocState;
}

extension TmplBlocStateStateUtils on TmplBlocState {
  bool isLoadingCompleted(TmplBlocState nextState) =>
      isLoading && !nextState.isLoading;
}
