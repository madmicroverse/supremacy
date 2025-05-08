import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:injectable/injectable.dart';

import '../presentation/bloc/sag_game_home_be.dart';
import '../presentation/bloc/sag_game_home_bloc.dart';
import '../presentation/view/sag_game_home_route_widget.dart';

const sagGameHomeRoutWidget = "sagGameHomeRoutWidget";

@module
abstract class SagGameHomeModule {
  @Injectable()
  SagGameHomeBloc sagGameHomeBlocFactory(IRouter router) {
    return SagGameHomeBloc(router);
  }

  @Named(sagGameHomeRoutWidget)
  @Injectable()
  Widget sagGameHomeRouteWidgetFactory(
    SagGameHomeBloc bloc,
    @factoryParam Widget child,
  ) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitSAGGameHomeBE()),
      child: SagGameHomeRouteWidget(child: child),
    );
  }
}
