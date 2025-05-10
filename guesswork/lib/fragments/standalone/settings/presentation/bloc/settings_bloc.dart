import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/sign_out_use_case.dart';
import 'package:guesswork/di/modules/router_module.dart';
import 'package:guesswork/fragments/standalone/settings/domain/use_case/get_game_settings_stream_use_case.dart';
import 'package:guesswork/fragments/standalone/settings/domain/use_case/set_game_settings_use_case.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'settings_be.dart';
import 'settings_bsc.dart';

class SettingsBloc extends Bloc<SettingsBE, SettingsBSC> {
  final IRouter _router;
  final GetGamesSettingsStreamUseCase _getGamesSettingsUseCase;
  final SetGamesSettingsUseCase _setGamesSettingsUseCase;
  final SignOutUseCase _signOutUseCase;

  StreamSubscription<GamesSettings>? _gamesSettingsSubscription;

  SettingsBloc(
    this._router,
    this._getGamesSettingsUseCase,
    this._setGamesSettingsUseCase,
    this._signOutUseCase,
  ) : super(SettingsBSC()) {
    on<InitSettingsBE>(_initSettingsBE);
    on<UpdateSettingsBE>(_updateSettingsBE);
    on<SwitchSettingsBE>(_switchSettingsBE);
    on<PopBE>(_popBE);
    on<SignOutBE>(_signOutBE);
  }

  FutureOr<void> _initSettingsBE(
    InitSettingsBE event,
    Emitter<SettingsBSC> emit,
  ) async {
    final packageInfo = await PackageInfo.fromPlatform();
    emit(state.withVersion(packageInfo.version));
    final result = await _getGamesSettingsUseCase();
    switch (result) {
      case Success():
        _gamesSettingsSubscription?.cancel();
        _gamesSettingsSubscription = result.data.listen((gamesSettings) {
          add(UpdateSettingsBE(gamesSettings));
        });
      case Error():
        final error = result.error;
        switch (error) {
          case GetGamesSettingsStreamUseCaseUnauthorizedError():
            _router.goNamed(signInRouteName);
          case GetGamesSettingsStreamUseCaseDataAccessError():
            emit(state.withError(SettingsReadDataAccessError()));
        }
    }
  }

  FutureOr<void> _updateSettingsBE(
    UpdateSettingsBE event,
    Emitter<SettingsBSC> emit,
  ) {
    emit(state.withGamesSettings(event.gameSettings));
  }

  FutureOr<void> _switchSettingsBE(
    SwitchSettingsBE event,
    Emitter<SettingsBSC> emit,
  ) async {
    final result = await _setGamesSettingsUseCase(event.gameSettings);
    switch (result) {
      case Success():
        return;
      case Error():
        final error = result.error;
        switch (error) {
          case SetGamesSettingsUseCaseUnauthorizedError():
            _router.goNamed(signInRouteName);
          case SetGamesSettingsUseCaseSystemError():
            emit(state.withError(SettingsSystemError()));
        }
    }
  }

  @override
  Future<void> close() {
    _gamesSettingsSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _signOutBE(SignOutBE event, Emitter<SettingsBSC> emit) {
    _signOutUseCase();
    _router.goNamed(signInRouteName);
  }

  FutureOr<void> _popBE(PopBE event, Emitter<SettingsBSC> emit) {
    _router.pop();
  }
}
