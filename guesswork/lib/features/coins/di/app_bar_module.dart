import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_game_user_info_use_case.dart';
import 'package:guesswork/features/coins/presentation/bloc/coins_be.dart';
import 'package:guesswork/features/coins/presentation/bloc/coins_bloc.dart';
import 'package:guesswork/features/coins/presentation/view/coins_widget.dart';
import 'package:injectable/injectable.dart';

const coinsWidget = "coinsWidget";

@module
abstract class CoinsModule {
  @Injectable()
  CoinsBloc appBarBlocFactory(
    IRouter router,
    GetGamesUserInfoUseCase getGamesUserInfoUseCase,
  ) {
    return CoinsBloc(router, getGamesUserInfoUseCase);
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
