import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/upsert_games_favorite_operation.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/data/repository/games_favorite_repository_impl.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/use_case/upsert_favorite_use_case.dart';
import 'package:guesswork/fragments/components/favorite_button/presentation/bloc/favorite_button_be.dart';
import 'package:injectable/injectable.dart';

import '../presentation/bloc/favorite_button_bloc.dart';
import '../presentation/view/favorite_button_widget.dart';

const sagGameFavoriteButtonWidget = "sagGameFavoriteButtonWidget";

@module
abstract class FavoriteButtonModule {
  @Injectable()
  UpsertFavoriteOperation upsertFavoriteOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return UpsertFavoriteOperation(firebaseFirestore);
  }

  @Injectable()
  GamesFavoriteRepository gamesFavoriteRepositoryFactory(
    UpsertFavoriteOperation upsertFavoriteOperation,
  ) {
    return GamesFavoriteRepositoryImpl(upsertFavoriteOperation);
  }

  @Injectable()
  UpsertGamesFavoriteUseCase upsertGamesFavoriteUseCaseFactory(
    AccountRepository accountRepository,
    GamesFavoriteRepository gamesFavoriteRepository,
  ) {
    return UpsertGamesFavoriteUseCase(
      accountRepository,
      gamesFavoriteRepository,
    );
  }

  @Injectable()
  FavoriteButtonBloc appBarBlocFactory(
    IRouter router,
    UpsertGamesFavoriteUseCase upsertGamesFavoriteUseCase,
  ) {
    return FavoriteButtonBloc(router, upsertGamesFavoriteUseCase);
  }

  @Named(sagGameFavoriteButtonWidget)
  @Injectable()
  Widget sagGameFavoriteButtonComponentFactory(
    FavoriteButtonBloc bloc,
    @factoryParam SAGGame sagGame,
  ) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitSAGGameFavoriteBE(sagGame)),
      child: FavoriteButton(
        opTap: () => bloc.add(SelectSAGGameFavoriteBE(sagGame)),
      ),
    );
  }
}
