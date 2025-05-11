import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/internet_available_stream_use_case.dart';
import 'package:guesswork/fragments/standalone/app_wrapper/presentation/bloc/app_wrapper_be.dart';
import 'package:injectable/injectable.dart';

import '../presentation/bloc/app_wrapper_bloc.dart';
import '../presentation/view/app_wrapper_route_widget.dart';

const appWrapperWidget = "appWrapperWidget";

@module
abstract class AppWrapperModule {
  @Injectable()
  AppWrapperBloc appWrapperBlocFactory(
    IRouter router,
    GetInternetAvailabilityStreamUseCase getInternetAvailabilityStreamUseCase,
  ) {
    return AppWrapperBloc(router, getInternetAvailabilityStreamUseCase);
  }

  @Named(appWrapperWidget)
  @Injectable()
  Widget appWrapperRouteWidgetFactory(
    AppWrapperBloc bloc,
    @factoryParam Widget child,
  ) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitAppWrapperBE()),
      child: AppWrapperRouteWidget(child: child),
    );
  }
}
