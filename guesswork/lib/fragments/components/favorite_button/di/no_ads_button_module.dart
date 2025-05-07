import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:injectable/injectable.dart';

import '../presentation/bloc/no_ads_button_bloc.dart';
import '../presentation/view/no_ads_button_widget.dart';

const noAdsButtonWidget = "noAdsButtonWidget";

@module
abstract class NoAdsButtonModule {
  @Injectable()
  NoAdsButtonBloc appBarBlocFactory(IRouter router) {
    return NoAdsButtonBloc(router);
  }

  @Named(noAdsButtonWidget)
  @Injectable()
  Widget appBarWidgetFactory(NoAdsButtonBloc bloc) {
    return BlocProvider(lazy: false, create: (_) => bloc, child: NoAdsButton());
  }
}
