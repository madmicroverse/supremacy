import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/coins/domain/use_case/get_coins_stream_use_case.dart';
import 'package:guesswork/fragments/standalone/settings/domain/use_case/get_game_settings_stream_use_case.dart';
import 'package:injectable/injectable.dart';

import '../presentation/bloc/coins_be.dart';
import '../presentation/bloc/coins_bloc.dart';
import '../presentation/view/coins_widget.dart';

const coinsWidget = "coinsWidget";

@module
abstract class CoinsModule {
  @Injectable()
  GetCoinsStreamUseCase getCoinsStreamUseCaseFactory(
    AccountRepository accountRepository,
  ) {
    return GetCoinsStreamUseCase(accountRepository);
  }

  @Injectable()
  CoinsBloc coinsBlocFactory(
    IRouter router,
    GetCoinsStreamUseCase getCoinsStreamUseCase,
    GetGamesSettingsStreamUseCase getGamesSettingsStreamUseCase,
  ) {
    return CoinsBloc(
      router,
      getCoinsStreamUseCase,
      getGamesSettingsStreamUseCase,
    );
  }

  @Named(coinsWidget)
  @Injectable()
  Widget appBarWidgetFactory(CoinsBloc bloc) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitCoinsBE()),
      child: Coins(),
    );
  }
}
