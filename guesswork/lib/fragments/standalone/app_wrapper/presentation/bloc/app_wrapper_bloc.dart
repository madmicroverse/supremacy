import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'app_wrapper_be.dart';
import 'app_wrapper_bs.dart';

class AppWrapperBloc extends Bloc<AppWrapperBE, AppWrapperBS> {
  final IRouter _router;

  StreamSubscription<InternetStatus>? _internetStatusSubscription;

  AppWrapperBloc(this._router) : super(AppWrapperBS()) {
    on<InitAppWrapperBE>(_initAppWrapperBE);
    on<ErrorBE>(_errorBE);
    on<NoErrorBE>(_noErrorBE);
  }

  FutureOr<void> _initAppWrapperBE(
    InitAppWrapperBE event,
    Emitter<AppWrapperBS> emit,
  ) async {
    _internetStatusSubscription = InternetConnection().onStatusChange.listen((
      InternetStatus status,
    ) {
      switch (status) {
        case InternetStatus.connected:
          add(NoErrorBE());
        case InternetStatus.disconnected:
          add(ErrorBE(AppWrapperNoInternetError()));
      }
    });
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
