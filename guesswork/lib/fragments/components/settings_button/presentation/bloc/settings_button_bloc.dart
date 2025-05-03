import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';
import 'package:guesswork/di/modules/router_module.dart';

import 'settings_button_be.dart';
import 'settings_button_bsc.dart';

class SettingsButtonBloc
    extends Bloc<SettingsButtonBE, BlocState<SettingsButtonBSC>> {
  final IRouter _router;

  SettingsButtonBloc(this._router)
    : super(
        BlocState<SettingsButtonBSC>(
          status: IdleStateStatus(),
          content: SettingsButtonBSC(),
        ),
      ) {
    on<ShowSettingsBE>(_showSettingsButtonBE);
  }

  FutureOr<void> _showSettingsButtonBE(
    ShowSettingsBE event,
    Emitter<BlocState<SettingsButtonBSC>> emit,
  ) async {
    await _router.pushNamed(settingsRouteName);
  }
}
