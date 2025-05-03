import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/features/settings_button/presentation/bloc/settings_button_bloc.dart';
import 'package:guesswork/features/settings_button/presentation/view/settings_button_widget.dart';
import 'package:injectable/injectable.dart';

const settingsButtonWidget = "settingsButtonWidget";

@module
abstract class SettingsButtonModule {
  @Injectable()
  SettingsButtonBloc appBarBlocFactory(IRouter router) {
    return SettingsButtonBloc(router);
  }

  @Named(settingsButtonWidget)
  @Injectable()
  Widget appBarWidgetFactory(SettingsButtonBloc bloc) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc,
      child: SettingsButton(),
    );
  }
}
