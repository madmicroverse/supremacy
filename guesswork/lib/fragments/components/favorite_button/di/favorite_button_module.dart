import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/delete_sag_game_favorite_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/get_sag_games_favorites_stream_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/upsert_sag_game_favorite_operation.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/core/domain/use_case/get_sag_game_favorites_stream_use_case.dart';
import 'package:guesswork/fragments/components/favorite_button/data/repository/games_favorite_repository_impl.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/use_case/delete_sag_game_favorite_use_case.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/use_case/upsert_sag_game_favorite_use_case.dart';
import 'package:guesswork/fragments/components/favorite_button/presentation/bloc/favorite_button_be.dart';
import 'package:injectable/injectable.dart';

import '../presentation/bloc/favorite_button_bloc.dart';
import '../presentation/view/favorite_button_widget.dart';

const sagGameFavoriteButtonWidget = "sagGameFavoriteButtonWidget";

@module
abstract class FavoriteButtonModule {
  @Injectable()
  UpsertSAGGameFavoriteOperation upsertFavoriteOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return UpsertSAGGameFavoriteOperation(firebaseFirestore);
  }

  @Injectable()
  GetSAGGameFavoritesStreamOperation getGamesFavoritesStreamOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return GetSAGGameFavoritesStreamOperation(firebaseFirestore);
  }

  @Injectable()
  DeleteSAGGameFavoriteOperation deleteSAGGameFavoriteOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return DeleteSAGGameFavoriteOperation(firebaseFirestore);
  }

  @Singleton()
  SAGGameFavoriteRepository gamesFavoriteRepositoryFactory(
    UpsertSAGGameFavoriteOperation upsertSAGGameFavoriteOperation,
    GetSAGGameFavoritesStreamOperation getSAGGameFavoritesStreamOperation,
    DeleteSAGGameFavoriteOperation deleteSAGGameFavoriteOperation,
  ) {
    return GamesFavoriteRepositoryImpl(
      upsertSAGGameFavoriteOperation,
      getSAGGameFavoritesStreamOperation,
      deleteSAGGameFavoriteOperation,
    );
  }

  @Injectable()
  UpsertSAGGameFavoriteUseCase upsertGamesFavoriteUseCaseFactory(
    AccountRepository accountRepository,
    SAGGameFavoriteRepository gamesFavoriteRepository,
  ) {
    return UpsertSAGGameFavoriteUseCase(
      accountRepository,
      gamesFavoriteRepository,
    );
  }

  @Injectable()
  DeleteSAGGameFavoriteUseCase deleteSAGGameFavoriteUseCaseFactory(
    AccountRepository accountRepository,
    SAGGameFavoriteRepository gamesFavoriteRepository,
  ) {
    return DeleteSAGGameFavoriteUseCase(
      accountRepository,
      gamesFavoriteRepository,
    );
  }

  @Injectable()
  GetSAGGameFavoritesStreamUseCase getGamesFavoritesStreamUseCaseFactory(
    AccountRepository accountRepository,
    SAGGameFavoriteRepository gamesFavoriteRepository,
  ) {
    return GetSAGGameFavoritesStreamUseCase(
      accountRepository,
      gamesFavoriteRepository,
    );
  }

  @Injectable()
  FavoriteButtonBloc favoriteButtonBlocFactory(
    IRouter router,
    UpsertSAGGameFavoriteUseCase upsertGamesFavoriteUseCase,
    GetSAGGameFavoritesStreamUseCase getGamesFavoritesStreamUseCase,
    DeleteSAGGameFavoriteUseCase deleteSAGGameFavoriteUseCase,
  ) {
    return FavoriteButtonBloc(
      router,
      upsertGamesFavoriteUseCase,
      getGamesFavoritesStreamUseCase,
      deleteSAGGameFavoriteUseCase,
    );
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
      child: FavoriteButton(),
    );
  }
}
