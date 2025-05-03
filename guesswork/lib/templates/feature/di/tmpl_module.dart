import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:injectable/injectable.dart';

import '../presentation/bloc/tmpl_bloc.dart';
import '../presentation/bloc/tmpl_bloc_events.dart';
import '../presentation/view/tmpl_route_widget.dart';

const tmplWidget = "tmplRouteWidget";

@module
abstract class TmplModule {
  @Injectable()
  TmplBloc tmplBlocFactory(IRouter router) {
    return TmplBloc(router);
  }

  @Named(tmplWidget)
  @Injectable()
  Widget tmplRouteWidgetFactory(TmplBloc bloc) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitTmplBlocEvent()),
      child: TmplRouteWidget(),
    );
  }
}
