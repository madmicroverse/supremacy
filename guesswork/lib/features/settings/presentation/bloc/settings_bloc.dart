import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_game_settings_use_case.dart';
import 'package:guesswork/core/domain/use_case/set_game_settings_use_case.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';

import 'settings_be.dart';
import 'settings_bsc.dart';

class SettingsBloc extends Bloc<SettingsBE, BlocState<SettingsBSC>> {
  final IRouter _router;
  final GetGamesSettingsUseCase _getGamesSettingsUseCase;
  final SetGamesSettingsUseCase _setGamesSettingsUseCase;

  StreamSubscription<GamesSettings>? _gamesSettingsSubscription;

  SettingsBloc(
    this._router,
    this._getGamesSettingsUseCase,
    this._setGamesSettingsUseCase,
  ) : super(
        BlocState<SettingsBSC>(
          status: LoadingStateStatus(),
          content: SettingsBSC(),
        ),
      ) {
    on<InitSettingsBE>(_initSettingsBE);
    on<UpdateSettingsBE>(_updateSettingsBE);
    on<SwitchSettingsBE>(_switchSettingsBE);
  }

  FutureOr<void> _initSettingsBE(
    InitSettingsBE event,
    Emitter<BlocState<SettingsBSC>> emit,
  ) async {
    final result = await _getGamesSettingsUseCase();
    switch (result) {
      case Success():
        _gamesSettingsSubscription = result.data.listen((gamesSettings) {
          add(UpdateSettingsBE(gamesSettings));
        });
      case Error():
        switch (result.error) {
          default:
            return emit(state.errorState(result.error.toString()));
        }
    }
  }

  FutureOr<void> _updateSettingsBE(
    UpdateSettingsBE event,
    Emitter<BlocState<SettingsBSC>> emit,
  ) {
    emit(state.idleState.withGamesSettings(event.gameSettings));
  }

  FutureOr<void> _switchSettingsBE(
    SwitchSettingsBE event,
    Emitter<BlocState<SettingsBSC>> emit,
  ) async {
    final result = await _setGamesSettingsUseCase(event.gameSettings);
    switch (result) {
      case Success():
        return;
      case Error():
      // TODO perhaps try again?
    }
  }

  @override
  Future<void> close() {
    _gamesSettingsSubscription?.cancel();
    return super.close();
  }
}
