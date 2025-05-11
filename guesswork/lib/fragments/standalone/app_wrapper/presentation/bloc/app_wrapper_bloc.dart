import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/internet_available_stream_use_case.dart';

import 'app_wrapper_be.dart';
import 'app_wrapper_bs.dart';

class AppWrapperBloc extends Bloc<AppWrapperBE, AppWrapperBS> {
  final IRouter _router;
  final GetInternetAvailabilityStreamUseCase
  _getInternetAvailabilityStreamUseCase;

  StreamSubscription<void>? _internetStatusSubscription;

  AppWrapperBloc(this._router, this._getInternetAvailabilityStreamUseCase)
    : super(AppWrapperBS()) {
    on<InitAppWrapperBE>(_initAppWrapperBE);
    on<ErrorBE>(_errorBE);
    on<NoErrorBE>(_noErrorBE);
  }

  FutureOr<void> _initAppWrapperBE(
    InitAppWrapperBE event,
    Emitter<AppWrapperBS> emit,
  ) async {
    final result = await _getInternetAvailabilityStreamUseCase();

    switch (result) {
      case Success<Stream<bool>, GetInternetAvailabilityStreamUseCaseError>():
        _internetStatusSubscription = result.data.listen((
          bool isInternetAvailable,
        ) {
          switch (isInternetAvailable) {
            case true:
              add(NoErrorBE());
            case false:
              add(ErrorBE(AppWrapperNoInternetError()));
          }
        });
      case Error<Stream<bool>, GetInternetAvailabilityStreamUseCaseError>():
        final error = result.error;
        switch (error) {
          case GetGamesSettingsStreamUseCaseDataAccessError():
            await Future.delayed(1000.ms);
            add(InitAppWrapperBE());
        }
    }
  }

  FutureOr<void> _errorBE(ErrorBE event, Emitter<AppWrapperBS> emit) {
    emit(state.withAppWrapperError(event.appWrapperError));
  }

  FutureOr<void> _noErrorBE(NoErrorBE event, Emitter<AppWrapperBS> emit) {
    emit(state.withoutAppWrapperError);
  }

  @override
  Future<void> close() {
    _internetStatusSubscription?.cancel();
    return super.close();
  }
}
