import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/di/modules/router_module.dart';

import 'settings_button_be.dart';
import 'settings_button_bsc.dart';

class SettingsButtonBloc extends Bloc<SettingsButtonBE, SettingsButtonBSC> {
  final IRouter _router;

  SettingsButtonBloc(this._router) : super(SettingsButtonBSC()) {
    on<ShowSettingsBE>(_showSettingsButtonBE);
  }

  FutureOr<void> _showSettingsButtonBE(
    ShowSettingsBE event,
    Emitter<SettingsButtonBSC> emit,
  ) async {
    await _router.pushNamed(settingsRouteName);
  }
}
