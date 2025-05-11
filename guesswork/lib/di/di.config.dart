// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:flutter/material.dart' as _i409;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:guesswork/core/data/framework/firebase/firestore/get_games_user_operation.dart'
    as _i462;
import 'package:guesswork/core/data/framework/firebase/firestore/get_games_user_stream_operation.dart'
    as _i30;
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/delete_sag_game_favorite_operation.dart'
    as _i775;
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/get_sag_games_favorites_stream_operation.dart'
    as _i810;
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/upsert_sag_game_favorite_operation.dart'
    as _i143;
import 'package:guesswork/core/data/framework/firebase/firestore/set_games_user_operation.dart'
    as _i160;
import 'package:guesswork/core/data/framework/firebase/sign_in_anonymously.dart'
    as _i479;
import 'package:guesswork/core/data/framework/firebase/sign_in_with_google.dart'
    as _i187;
import 'package:guesswork/core/data/framework/firebase/sign_out.dart' as _i963;
import 'package:guesswork/core/data/framework/firebase/signed_status.dart'
    as _i901;
import 'package:guesswork/core/data/framework/firebase/user_framework.dart'
    as _i529;
import 'package:guesswork/core/data/framework/internet_availability_operation.dart'
    as _i1003;
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart' as _i815;
import 'package:guesswork/core/domain/framework/router.dart' as _i5;
import 'package:guesswork/core/domain/repository/account_repository.dart'
    as _i128;
import 'package:guesswork/core/domain/repository/auth_repository.dart' as _i440;
import 'package:guesswork/core/domain/repository/image_repository.dart'
    as _i780;
import 'package:guesswork/core/domain/repository/internet_available_repository.dart'
    as _i1067;
import 'package:guesswork/core/domain/use_case/add_coins_use_case.dart'
    as _i659;
import 'package:guesswork/core/domain/use_case/get_network_image_use_case.dart'
    as _i861;
import 'package:guesswork/core/domain/use_case/get_sag_game_favorites_stream_use_case.dart'
    as _i375;
import 'package:guesswork/core/domain/use_case/internet_available_stream_use_case.dart'
    as _i346;
import 'package:guesswork/core/domain/use_case/internet_available_use_case.dart'
    as _i43;
import 'package:guesswork/core/domain/use_case/sign_out_use_case.dart' as _i599;
import 'package:guesswork/di/modules/account_module.dart' as _i550;
import 'package:guesswork/di/modules/app_module.dart' as _i1048;
import 'package:guesswork/di/modules/firebase_module.dart' as _i932;
import 'package:guesswork/di/modules/global.dart' as _i994;
import 'package:guesswork/di/modules/router_module.dart' as _i750;
import 'package:guesswork/fragments/components/app_bar/di/app_bar_module.dart'
    as _i488;
import 'package:guesswork/fragments/components/app_bar/presentation/bloc/app_bar_bloc.dart'
    as _i271;
import 'package:guesswork/fragments/components/coins/di/app_bar_module.dart'
    as _i233;
import 'package:guesswork/fragments/components/coins/domain/use_case/get_coins_stream_use_case.dart'
    as _i840;
import 'package:guesswork/fragments/components/coins/presentation/bloc/coins_bloc.dart'
    as _i355;
import 'package:guesswork/fragments/components/favorite_button/di/favorite_button_module.dart'
    as _i343;
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart'
    as _i572;
import 'package:guesswork/fragments/components/favorite_button/domain/use_case/delete_sag_game_favorite_use_case.dart'
    as _i654;
import 'package:guesswork/fragments/components/favorite_button/domain/use_case/upsert_sag_game_favorite_use_case.dart'
    as _i660;
import 'package:guesswork/fragments/components/favorite_button/presentation/bloc/favorite_button_bloc.dart'
    as _i188;
import 'package:guesswork/fragments/components/no_ads_button/di/no_ads_button_module.dart'
    as _i496;
import 'package:guesswork/fragments/components/no_ads_button/presentation/bloc/no_ads_button_bloc.dart'
    as _i366;
import 'package:guesswork/fragments/components/settings_button/di/settings_button_module.dart'
    as _i659;
import 'package:guesswork/fragments/components/settings_button/presentation/bloc/settings_button_bloc.dart'
    as _i581;
import 'package:guesswork/fragments/standalone/app_wrapper/di/app_wrapper_module.dart'
    as _i8;
import 'package:guesswork/fragments/standalone/app_wrapper/presentation/bloc/app_wrapper_bloc.dart'
    as _i99;
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/CreateSagGameOperation.dart'
    as _i1029;
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGameOperation.dart'
    as _i938;
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart'
    as _i207;
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/upsert_user_sag_game_operation.dart'
    as _i345;
import 'package:guesswork/fragments/standalone/sag/sag_game/di/sag_game_module.dart'
    as _i239;
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/repository/sag_game_repository.dart'
    as _i664;
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/use_case/create_sag_game_use_case.dart'
    as _i668;
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/use_case/get_sag_game_use_case.dart'
    as _i484;
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/use_case/upsert_user_sag_game_use_case.dart'
    as _i887;
import 'package:guesswork/fragments/standalone/sag/sag_game/presentation/bloc/sag_game_bloc.dart'
    as _i544;
import 'package:guesswork/fragments/standalone/sag/sag_game_home/di/sag_game_home_module.dart'
    as _i492;
import 'package:guesswork/fragments/standalone/sag/sag_game_home/presentation/bloc/sag_game_home_bloc.dart'
    as _i71;
import 'package:guesswork/fragments/standalone/sag/sag_game_item/di/sag_game_item_module.dart'
    as _i404;
import 'package:guesswork/fragments/standalone/sag/sag_game_item/presentation/bloc/sag_game_item_bloc.dart'
    as _i374;
import 'package:guesswork/fragments/standalone/sag/sag_games/di/sag_games_module.dart'
    as _i78;
import 'package:guesswork/fragments/standalone/sag/sag_games/domain/use_case/get_sag_games_use_case.dart'
    as _i430;
import 'package:guesswork/fragments/standalone/sag/sag_games/presentation/bloc/sag_games_bloc.dart'
    as _i24;
import 'package:guesswork/fragments/standalone/settings/di/settings_module.dart'
    as _i52;
import 'package:guesswork/fragments/standalone/settings/domain/use_case/get_game_settings_stream_use_case.dart'
    as _i878;
import 'package:guesswork/fragments/standalone/settings/domain/use_case/set_game_settings_use_case.dart'
    as _i244;
import 'package:guesswork/fragments/standalone/settings/presentation/bloc/settings_bloc.dart'
    as _i1011;
import 'package:guesswork/fragments/standalone/sign_in/di/sign_in_module.dart'
    as _i193;
import 'package:guesswork/fragments/standalone/sign_in/domain/use_case/anonymous_sign_in_use_case.dart'
    as _i315;
import 'package:guesswork/fragments/standalone/sign_in/domain/use_case/apple_sign_in_use_case.dart'
    as _i216;
import 'package:guesswork/fragments/standalone/sign_in/domain/use_case/google_sign_in_use_case.dart'
    as _i809;
import 'package:guesswork/fragments/standalone/sign_in/presentation/bloc/sign_in_bloc.dart'
    as _i268;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final global = _$Global();
    final appModule = _$AppModule();
    final signInModule = _$SignInModule();
    final appBarModule = _$AppBarModule();
    final firebaseModule = _$FirebaseModule();
    final navModule = _$NavModule();
    final accountModule = _$AccountModule();
    final sAGGameModule = _$SAGGameModule();
    final favoriteButtonModule = _$FavoriteButtonModule();
    final coinsModule = _$CoinsModule();
    final sagGameHomeModule = _$SagGameHomeModule();
    final settingsButtonModule = _$SettingsButtonModule();
    final noAdsButtonModule = _$NoAdsButtonModule();
    final appWrapperModule = _$AppWrapperModule();
    final settingsModule = _$SettingsModule();
    final scratchAndGuessModule = _$ScratchAndGuessModule();
    final sAGGamesModule = _$SAGGamesModule();
    gh.factory<_i1003.InternetAvailabilityStreamOperation>(
      () => global.internetAvailabilityStreamOperationFactory(),
    );
    gh.factory<_i780.ImageRepository>(() => global.imageRepositoryFactory());
    await gh.factoryAsync<_i409.ThemeData>(
      () => appModule.themeDataFactory(),
      preResolve: true,
    );
    gh.factory<_i809.GoogleSignInUseCase>(
      () => signInModule.googleSignInUseCase,
    );
    gh.factory<_i216.AppleSignInUseCase>(() => signInModule.appleSignInUseCase);
    gh.factory<_i271.AppBarBloc>(() => appBarModule.appBarBlocFactory());
    await gh.singletonAsync<_i982.FirebaseApp>(
      () => firebaseModule.firebaseAppFactory(),
      preResolve: true,
    );
    await gh.singletonAsync<_i59.FirebaseAuth>(
      () => firebaseModule.firebaseAuthFactory(),
      preResolve: true,
    );
    await gh.singletonAsync<_i974.FirebaseFirestore>(
      () => firebaseModule.firebaseFirestoreFactory(),
      preResolve: true,
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.sagGameItemRouteFactory(),
      instanceName: 'sagGameItemRouteName',
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.signInRouteFactory(),
      instanceName: 'signInRouteName',
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.sagGamesTopRouteFactory(),
      instanceName: 'sagGamesTopRouteName',
    );
    gh.singleton<_i529.GetAuthGamesUserOperation>(
      () => accountModule.userFrameworkFactory(gh<_i59.FirebaseAuth>()),
    );
    gh.singleton<_i187.SignInWithGoogle>(
      () => accountModule.signInWithGoogleFactory(gh<_i59.FirebaseAuth>()),
    );
    gh.singleton<_i479.SignInAnonymous>(
      () => accountModule.signInAnonymousFactory(gh<_i59.FirebaseAuth>()),
    );
    gh.singleton<_i963.SignOut>(
      () => accountModule.signOutFactory(gh<_i59.FirebaseAuth>()),
    );
    gh.singleton<_i901.SignedStatus>(
      () => accountModule.signedStatusFactory(gh<_i59.FirebaseAuth>()),
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.sagGamesReplyRouteFactory(),
      instanceName: 'sagGamesReplyRouteName',
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.sagGameRouteFactory(),
      instanceName: 'sagGameRouteName',
    );
    gh.singleton<_i1029.CreateSagGameOperation>(
      () => sAGGameModule.createSagGameOperationFactory(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.singleton<_i938.GetSagGameOperation>(
      () => sAGGameModule.getSagGameOperationFactory(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.singleton<_i207.GetSagGamesOperation>(
      () => sAGGameModule.getSagGamesOperationFactory(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.singleton<_i462.GetGamesUserOperation>(
      () => sAGGameModule.getGamesUserOperationFactory(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.singleton<_i30.GetGamesUserStreamOperation>(
      () => sAGGameModule.getGamesUserStreamOperationFactory(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.singleton<_i160.SetGamesUserOperation>(
      () => sAGGameModule.setGamesUserOperationFactory(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.singleton<_i345.UpsertUserSAGGameOperation>(
      () => sAGGameModule.upsertUserSAGGameOperationFactory(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i143.UpsertSAGGameFavoriteOperation>(
      () => favoriteButtonModule.upsertFavoriteOperationFactory(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i810.GetSAGGameFavoritesStreamOperation>(
      () => favoriteButtonModule.getGamesFavoritesStreamOperationFactory(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i775.DeleteSAGGameFavoriteOperation>(
      () => favoriteButtonModule.deleteSAGGameFavoriteOperationFactory(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.sagGamesMainRouteFactory(),
      instanceName: 'sagGamesMainRouteName',
    );
    gh.factory<_i440.AuthRepository>(
      () => accountModule.authRepositoryFactory(
        gh<_i187.SignInWithGoogle>(),
        gh<_i479.SignInAnonymous>(),
        gh<_i963.SignOut>(),
        gh<_i901.SignedStatus>(),
      ),
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.sagGamesFavoriteRouteFactory(),
      instanceName: 'sagGamesFavoriteRouteName',
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.settingsRouteFactory(),
      instanceName: 'settingsRouteName',
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.sagGamesEventRouteFactory(),
      instanceName: 'sagGamesEventRouteName',
    );
    gh.singleton<_i572.SAGGameFavoriteRepository>(
      () => favoriteButtonModule.gamesFavoriteRepositoryFactory(
        gh<_i143.UpsertSAGGameFavoriteOperation>(),
        gh<_i810.GetSAGGameFavoritesStreamOperation>(),
        gh<_i775.DeleteSAGGameFavoriteOperation>(),
      ),
    );
    gh.factory<_i583.ShellRoute>(
      () => navModule.sagGamesHomeRouteFactory(
        gh<_i583.GoRoute>(instanceName: 'sagGamesFavoriteRouteName'),
        gh<_i583.GoRoute>(instanceName: 'sagGamesMainRouteName'),
        gh<_i583.GoRoute>(instanceName: 'sagGamesTopRouteName'),
        gh<_i583.GoRoute>(instanceName: 'sagGamesEventRouteName'),
        gh<_i583.GoRoute>(instanceName: 'sagGamesReplyRouteName'),
      ),
      instanceName: 'sagGamesHomeRouteName',
    );
    gh.factory<_i599.SignOutUseCase>(
      () => accountModule.signOutUseCaseFactory(gh<_i440.AuthRepository>()),
    );
    gh.factory<_i315.AnonymousSignInUseCase>(
      () => signInModule.anonymousSignInUseCase(gh<_i440.AuthRepository>()),
    );
    await gh.singletonAsync<_i583.GoRouter>(
      () => navModule.goRouterFactory(
        gh<_i440.AuthRepository>(),
        gh<_i583.GoRoute>(instanceName: 'signInRouteName'),
        gh<_i583.ShellRoute>(instanceName: 'sagGamesHomeRouteName'),
        gh<_i583.GoRoute>(instanceName: 'sagGameRouteName'),
        gh<_i583.GoRoute>(instanceName: 'sagGameItemRouteName'),
        gh<_i583.GoRoute>(instanceName: 'settingsRouteName'),
      ),
      preResolve: true,
    );
    gh.factory<_i1067.InternetAvailabilityRepository>(
      () => global.internetAvailabilityRepositoryFactory(
        gh<_i1003.InternetAvailabilityStreamOperation>(),
      ),
    );
    gh.factory<_i861.GetNetworkImageUseCase>(
      () => global.getNetworkImageUseCaseFactory(gh<_i780.ImageRepository>()),
    );
    gh.singleton<_i128.AccountRepository>(
      () => accountModule.accountRepositoryFactory(
        gh<_i529.GetAuthGamesUserOperation>(),
        gh<_i462.GetGamesUserOperation>(),
        gh<_i30.GetGamesUserStreamOperation>(),
        gh<_i160.SetGamesUserOperation>(),
      ),
    );
    gh.singleton<_i5.IRouter>(() => navModule.router(gh<_i583.GoRouter>()));
    gh.factory<_i346.GetInternetAvailabilityStreamUseCase>(
      () => global.getInternetAvailabilityStreamUseCaseFactory(
        gh<_i1067.InternetAvailabilityRepository>(),
      ),
    );
    gh.factory<_i43.GetInternetAvailabilityUseCase>(
      () => global.getInternetAvailabilityUseCaseFactory(
        gh<_i1067.InternetAvailabilityRepository>(),
      ),
    );
    gh.factory<_i409.MaterialApp>(
      () => appModule.crosswordBlockFactory(
        gh<_i409.ThemeData>(),
        gh<_i583.GoRouter>(),
      ),
    );
    gh.factory<_i664.SAGGameRepository>(
      () => sAGGameModule.sagGameRepositoryFactory(
        gh<_i1029.CreateSagGameOperation>(),
        gh<_i938.GetSagGameOperation>(),
        gh<_i207.GetSagGamesOperation>(),
        gh<_i345.UpsertUserSAGGameOperation>(),
      ),
    );
    gh.factory<_i878.GetGamesSettingsStreamUseCase>(
      () => accountModule.getGamesSettingsUseCaseFactory(
        gh<_i128.AccountRepository>(),
      ),
    );
    gh.factory<_i244.SetGamesSettingsUseCase>(
      () => accountModule.setGamesSettingsUseCaseFactory(
        gh<_i128.AccountRepository>(),
      ),
    );
    gh.factory<_i659.AddCoinsStreamUseCase>(
      () => accountModule.addCoinsStreamUseCaseFactory(
        gh<_i128.AccountRepository>(),
      ),
    );
    gh.factory<_i840.GetCoinsStreamUseCase>(
      () => coinsModule.getCoinsStreamUseCaseFactory(
        gh<_i128.AccountRepository>(),
      ),
    );
    gh.factory<_i355.CoinsBloc>(
      () => coinsModule.coinsBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i840.GetCoinsStreamUseCase>(),
        gh<_i878.GetGamesSettingsStreamUseCase>(),
      ),
    );
    gh.factory<_i71.SagGameHomeBloc>(
      () => sagGameHomeModule.sagGameHomeBlocFactory(gh<_i5.IRouter>()),
    );
    gh.factory<_i581.SettingsButtonBloc>(
      () => settingsButtonModule.appBarBlocFactory(gh<_i5.IRouter>()),
    );
    gh.factory<_i366.NoAdsButtonBloc>(
      () => noAdsButtonModule.appBarBlocFactory(gh<_i5.IRouter>()),
    );
    gh.factory<_i409.Widget>(
      () => coinsModule.appBarWidgetFactory(gh<_i355.CoinsBloc>()),
      instanceName: 'coinsWidget',
    );
    gh.factory<_i99.AppWrapperBloc>(
      () => appWrapperModule.appWrapperBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i346.GetInternetAvailabilityStreamUseCase>(),
      ),
    );
    gh.factory<_i887.UpsertUserSAGGameUseCase>(
      () => sAGGameModule.upsertUserSAGGameUseCaseFactory(
        gh<_i128.AccountRepository>(),
        gh<_i664.SAGGameRepository>(),
      ),
    );
    gh.factory<_i1011.SettingsBloc>(
      () => settingsModule.appBarBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i878.GetGamesSettingsStreamUseCase>(),
        gh<_i244.SetGamesSettingsUseCase>(),
        gh<_i599.SignOutUseCase>(),
      ),
    );
    gh.factory<_i430.GetSAGGamesUseCase>(
      () => sAGGameModule.getSAGGamesUseCaseFactory(
        gh<_i128.AccountRepository>(),
        gh<_i664.SAGGameRepository>(),
      ),
    );
    gh.factory<_i484.GetSAGGameUseCase>(
      () =>
          sAGGameModule.getSAGGameUseCaseFactory(gh<_i664.SAGGameRepository>()),
    );
    gh.factory<_i668.CreateSAGGameUseCase>(
      () => sAGGameModule.createSAGGameUseCaseFactory(
        gh<_i664.SAGGameRepository>(),
      ),
    );
    gh.factory<_i660.UpsertSAGGameFavoriteUseCase>(
      () => favoriteButtonModule.upsertGamesFavoriteUseCaseFactory(
        gh<_i128.AccountRepository>(),
        gh<_i572.SAGGameFavoriteRepository>(),
      ),
    );
    gh.factory<_i654.DeleteSAGGameFavoriteUseCase>(
      () => favoriteButtonModule.deleteSAGGameFavoriteUseCaseFactory(
        gh<_i128.AccountRepository>(),
        gh<_i572.SAGGameFavoriteRepository>(),
      ),
    );
    gh.factory<_i375.GetSAGGameFavoritesStreamUseCase>(
      () => favoriteButtonModule.getGamesFavoritesStreamUseCaseFactory(
        gh<_i128.AccountRepository>(),
        gh<_i572.SAGGameFavoriteRepository>(),
      ),
    );
    gh.factory<_i374.SAGGameItemBloc>(
      () => scratchAndGuessModule.sagGameItemBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i861.GetNetworkImageUseCase>(),
        gh<_i878.GetGamesSettingsStreamUseCase>(),
      ),
    );
    gh.factory<_i268.SignInBloc>(
      () => signInModule.signInBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i809.GoogleSignInUseCase>(),
        gh<_i216.AppleSignInUseCase>(),
        gh<_i315.AnonymousSignInUseCase>(),
      ),
    );
    gh.factory<_i409.Widget>(
      () => noAdsButtonModule.appBarWidgetFactory(gh<_i366.NoAdsButtonBloc>()),
      instanceName: 'noAdsButtonWidget',
    );
    gh.factory<_i544.SAGGameBloc>(
      () => sAGGameModule.gameSetBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i484.GetSAGGameUseCase>(),
        gh<_i887.UpsertUserSAGGameUseCase>(),
        gh<_i659.AddCoinsStreamUseCase>(),
        gh<_i878.GetGamesSettingsStreamUseCase>(),
      ),
    );
    gh.factoryParam<_i409.Widget, _i409.Widget, dynamic>(
      (child, _) => sagGameHomeModule.sagGameHomeRouteWidgetFactory(
        gh<_i71.SagGameHomeBloc>(),
        child,
      ),
      instanceName: 'sagGameHomeRoutWidget',
    );
    gh.factory<_i409.Widget>(
      () => signInModule.signInRouteWidgetFactory(gh<_i268.SignInBloc>()),
      instanceName: 'sign_inRouteWidget',
    );
    gh.factory<_i409.Widget>(
      () => settingsButtonModule.appBarWidgetFactory(
        gh<_i581.SettingsButtonBloc>(),
      ),
      instanceName: 'settingsButtonWidget',
    );
    gh.factoryParam<_i409.Widget, _i409.Widget, dynamic>(
      (child, _) => appWrapperModule.appWrapperRouteWidgetFactory(
        gh<_i99.AppWrapperBloc>(),
        child,
      ),
      instanceName: 'appWrapperWidget',
    );
    gh.factory<_i409.Widget>(
      () => settingsModule.appBarWidgetFactory(
        gh<_i1011.SettingsBloc>(),
        gh<_i409.Widget>(instanceName: 'noAdsButtonWidget'),
      ),
      instanceName: 'settingsRouteWidget',
    );
    gh.factory<_i409.PreferredSizeWidget>(
      () => appBarModule.appBarWidgetFactory(
        gh<_i271.AppBarBloc>(),
        gh<_i409.Widget>(instanceName: 'coinsWidget'),
        gh<_i409.Widget>(instanceName: 'settingsButtonWidget'),
        gh<_i409.Widget>(instanceName: 'noAdsButtonWidget'),
      ),
      instanceName: 'appBarWidget',
    );
    gh.factoryParam<_i409.Widget, String, dynamic>(
      (sagGameId, _) => sAGGameModule.gameSetRouteWidgetFactory(
        gh<_i544.SAGGameBloc>(),
        sagGameId,
        gh<_i409.PreferredSizeWidget>(instanceName: 'appBarWidget'),
      ),
      instanceName: 'sagGameRouteWidget',
    );
    gh.factory<_i24.SAGGamesBloc>(
      () => sAGGamesModule.sagGamesBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i430.GetSAGGamesUseCase>(),
        gh<_i375.GetSAGGameFavoritesStreamUseCase>(),
      ),
    );
    gh.factory<_i188.FavoriteButtonBloc>(
      () => favoriteButtonModule.favoriteButtonBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i660.UpsertSAGGameFavoriteUseCase>(),
        gh<_i375.GetSAGGameFavoritesStreamUseCase>(),
        gh<_i654.DeleteSAGGameFavoriteUseCase>(),
      ),
    );
    gh.factoryParam<_i409.Widget, _i815.SAGGameItem, dynamic>(
      (sagGameItem, _) => scratchAndGuessModule.sagGameItemRouteWidgetFactory(
        gh<_i374.SAGGameItemBloc>(),
        sagGameItem,
        gh<_i409.Widget>(instanceName: 'settingsButtonWidget'),
        gh<_i409.Widget>(instanceName: 'noAdsButtonWidget'),
      ),
      instanceName: 'sagGameItemRouteWidget',
    );
    gh.factoryParam<_i409.Widget, _i815.SAGGame, dynamic>(
      (sagGame, _) =>
          favoriteButtonModule.sagGameFavoriteButtonComponentFactory(
            gh<_i188.FavoriteButtonBloc>(),
            sagGame,
          ),
      instanceName: 'sagGameFavoriteButtonWidget',
    );
    gh.factoryParam<_i409.Widget, _i207.SAGGameSource, dynamic>(
      (sagGameSource, _) => sAGGamesModule.sagGamesRouteWidgetFactory(
        gh<_i24.SAGGamesBloc>(),
        gh<_i409.PreferredSizeWidget>(instanceName: 'appBarWidget'),
        sagGameSource,
      ),
      instanceName: 'sagGamesRouteWidget',
    );
    return this;
  }
}

class _$Global extends _i994.Global {}

class _$AppModule extends _i1048.AppModule {}

class _$SignInModule extends _i193.SignInModule {}

class _$AppBarModule extends _i488.AppBarModule {}

class _$FirebaseModule extends _i932.FirebaseModule {}

class _$NavModule extends _i750.NavModule {}

class _$AccountModule extends _i550.AccountModule {}

class _$SAGGameModule extends _i239.SAGGameModule {}

class _$FavoriteButtonModule extends _i343.FavoriteButtonModule {}

class _$CoinsModule extends _i233.CoinsModule {}

class _$SagGameHomeModule extends _i492.SagGameHomeModule {}

class _$SettingsButtonModule extends _i659.SettingsButtonModule {}

class _$NoAdsButtonModule extends _i496.NoAdsButtonModule {}

class _$AppWrapperModule extends _i8.AppWrapperModule {}

class _$SettingsModule extends _i52.SettingsModule {}

class _$ScratchAndGuessModule extends _i404.ScratchAndGuessModule {}

class _$SAGGamesModule extends _i78.SAGGamesModule {}
