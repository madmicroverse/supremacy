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
import 'package:guesswork/core/data/framework/firebase/firestore_framework.dart'
    as _i520;
import 'package:guesswork/core/data/framework/firebase/sign_in_anonymously.dart'
    as _i479;
import 'package:guesswork/core/data/framework/firebase/sign_in_with_google.dart'
    as _i187;
import 'package:guesswork/core/data/framework/firebase/sign_out.dart' as _i963;
import 'package:guesswork/core/data/framework/firebase/signed_status.dart'
    as _i901;
import 'package:guesswork/core/data/framework/firebase/user_framework.dart'
    as _i529;
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart' as _i815;
import 'package:guesswork/core/domain/framework/router.dart' as _i5;
import 'package:guesswork/core/domain/repository/account_repository.dart'
    as _i128;
import 'package:guesswork/core/domain/repository/auth_repository.dart' as _i440;
import 'package:guesswork/core/domain/repository/image_repository.dart'
    as _i780;
import 'package:guesswork/core/domain/use_case/get_game_settings_use_case.dart'
    as _i937;
import 'package:guesswork/core/domain/use_case/get_game_user_info_use_case.dart'
    as _i548;
import 'package:guesswork/core/domain/use_case/get_network_image_spect_ratio_use_case.dart'
    as _i973;
import 'package:guesswork/core/domain/use_case/get_network_image_use_case.dart'
    as _i861;
import 'package:guesswork/core/domain/use_case/set_game_settings_use_case.dart'
    as _i875;
import 'package:guesswork/core/domain/use_case/sign_out_use_case.dart' as _i599;
import 'package:guesswork/di/modules/account_module.dart' as _i550;
import 'package:guesswork/di/modules/app_module.dart' as _i1048;
import 'package:guesswork/di/modules/firebase_module.dart' as _i932;
import 'package:guesswork/di/modules/global.dart' as _i994;
import 'package:guesswork/di/modules/router_module.dart' as _i750;
import 'package:guesswork/features/app_bar/di/app_bar_module.dart' as _i591;
import 'package:guesswork/features/app_bar/presentation/bloc/app_bar_bloc.dart'
    as _i686;
import 'package:guesswork/features/coins/di/app_bar_module.dart' as _i455;
import 'package:guesswork/features/coins/presentation/bloc/coins_bloc.dart'
    as _i1028;
import 'package:guesswork/features/no_ads_button/di/no_ads_button_module.dart'
    as _i986;
import 'package:guesswork/features/no_ads_button/presentation/bloc/no_ads_button_bloc.dart'
    as _i108;
import 'package:guesswork/features/sag/sag_game/di/sag_game_module.dart'
    as _i166;
import 'package:guesswork/features/sag/sag_game/domain/repository/sag_game_repository.dart'
    as _i512;
import 'package:guesswork/features/sag/sag_game/domain/use_case/get_sag_game_use_case.dart'
    as _i287;
import 'package:guesswork/features/sag/sag_game/presentation/bloc/sag_game_bloc.dart'
    as _i559;
import 'package:guesswork/features/sag/sag_game_item/di/sag_game_item_module.dart'
    as _i77;
import 'package:guesswork/features/sag/sag_game_item/presentation/bloc/sag_game_item_bloc.dart'
    as _i553;
import 'package:guesswork/features/sag/sag_games/di/sag_games_module.dart'
    as _i333;
import 'package:guesswork/features/sag/sag_games/domain/use_case/get_sag_games_use_case.dart'
    as _i309;
import 'package:guesswork/features/sag/sag_games/presentation/bloc/sag_games_bloc.dart'
    as _i1050;
import 'package:guesswork/features/settings/di/settings_module.dart' as _i962;
import 'package:guesswork/features/settings/presentation/bloc/settings_bloc.dart'
    as _i226;
import 'package:guesswork/features/settings_button/di/settings_button_module.dart'
    as _i1025;
import 'package:guesswork/features/settings_button/presentation/bloc/settings_button_bloc.dart'
    as _i331;
import 'package:guesswork/features/sign_in/di/sign_in_module.dart' as _i945;
import 'package:guesswork/features/sign_in/domain/use_case/anonymous_sign_in_use_case.dart'
    as _i974;
import 'package:guesswork/features/sign_in/domain/use_case/apple_sign_in_use_case.dart'
    as _i810;
import 'package:guesswork/features/sign_in/domain/use_case/google_sign_in_use_case.dart'
    as _i544;
import 'package:guesswork/features/sign_in/presentation/bloc/sign_in_bloc.dart'
    as _i108;
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
    final sAGGameModule = _$SAGGameModule();
    final firebaseModule = _$FirebaseModule();
    final sAGGamesModule = _$SAGGamesModule();
    final navModule = _$NavModule();
    final accountModule = _$AccountModule();
    final settingsButtonModule = _$SettingsButtonModule();
    final noAdsButtonModule = _$NoAdsButtonModule();
    final coinsModule = _$CoinsModule();
    final settingsModule = _$SettingsModule();
    final scratchAndGuessModule = _$ScratchAndGuessModule();
    gh.factory<_i780.ImageRepository>(() => global.imageRepositoryFactory());
    await gh.factoryAsync<_i409.ThemeData>(
      () => appModule.themeDataFactory(),
      preResolve: true,
    );
    gh.factory<_i544.GoogleSignInUseCase>(
      () => signInModule.googleSignInUseCase,
    );
    gh.factory<_i810.AppleSignInUseCase>(() => signInModule.appleSignInUseCase);
    gh.factory<_i686.AppBarBloc>(() => appBarModule.appBarBlocFactory());
    gh.factory<_i512.SAGGameRepository>(
      () => sAGGameModule.sagGameRepositoryFactory(),
    );
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
    gh.factory<_i309.GetSAGGamesUseCase>(
      () => sAGGamesModule.getSAGGamesUseCaseFactory(
        gh<_i512.SAGGameRepository>(),
      ),
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.sagGameItemRouteFactory(),
      instanceName: 'sagGameItemRouteName',
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.signInRouteFactory(),
      instanceName: 'signInRouteName',
    );
    gh.singleton<_i529.UserFramework>(
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
    gh.factory<_i287.GetSAGGameUseCase>(
      () =>
          sAGGameModule.getSAGGameUseCaseFactory(gh<_i512.SAGGameRepository>()),
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.sagGameRouteFactory(),
      instanceName: 'sagGameRouteName',
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.sagGamesRouteFactory(),
      instanceName: 'sagGamesRouteName',
    );
    gh.singleton<_i520.FirestoreFramework>(
      () => global.firestoreFrameworkFactory(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i440.AuthRepository>(
      () => accountModule.authRepositoryFactory(
        gh<_i187.SignInWithGoogle>(),
        gh<_i479.SignInAnonymous>(),
        gh<_i963.SignOut>(),
        gh<_i901.SignedStatus>(),
      ),
    );
    gh.factory<_i128.AccountRepository>(
      () => accountModule.accountRepositoryFactory(
        gh<_i529.UserFramework>(),
        gh<_i520.FirestoreFramework>(),
      ),
    );
    gh.factory<_i583.GoRoute>(
      () => navModule.settingsRouteFactory(),
      instanceName: 'settingsRouteName',
    );
    gh.factory<_i599.SignOutUseCase>(
      () => accountModule.signOutUseCaseFactory(gh<_i440.AuthRepository>()),
    );
    gh.factory<_i974.AnonymousSignInUseCase>(
      () => signInModule.anonymousSignInUseCase(gh<_i440.AuthRepository>()),
    );
    gh.factory<_i861.GetNetworkImageUseCase>(
      () => global.getNetworkImageUseCaseFactory(gh<_i780.ImageRepository>()),
    );
    gh.factory<_i973.GetNetworkImageSizeUseCase>(
      () => global.getNetworkImageAspectRatioUseCaseFactory(
        gh<_i780.ImageRepository>(),
      ),
    );
    await gh.singletonAsync<_i583.GoRouter>(
      () => navModule.goRouterFactory(
        gh<_i440.AuthRepository>(),
        gh<_i583.GoRoute>(instanceName: 'signInRouteName'),
        gh<_i583.GoRoute>(instanceName: 'sagGamesRouteName'),
        gh<_i583.GoRoute>(instanceName: 'sagGameRouteName'),
        gh<_i583.GoRoute>(instanceName: 'sagGameItemRouteName'),
        gh<_i583.GoRoute>(instanceName: 'settingsRouteName'),
      ),
      preResolve: true,
    );
    gh.singleton<_i5.IRouter>(() => navModule.router(gh<_i583.GoRouter>()));
    gh.factory<_i1050.SAGGamesBloc>(
      () => sAGGamesModule.sagGamesBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i309.GetSAGGamesUseCase>(),
        gh<_i599.SignOutUseCase>(),
      ),
    );
    gh.factory<_i409.MaterialApp>(
      () => appModule.crosswordBlockFactory(
        gh<_i409.ThemeData>(),
        gh<_i583.GoRouter>(),
      ),
    );
    gh.factory<_i937.GetGamesSettingsUseCase>(
      () => accountModule.getGamesSettingsUseCaseFactory(
        gh<_i128.AccountRepository>(),
      ),
    );
    gh.factory<_i875.SetGamesSettingsUseCase>(
      () => accountModule.setGamesSettingsUseCaseFactory(
        gh<_i128.AccountRepository>(),
      ),
    );
    gh.factory<_i548.GetGamesUserInfoUseCase>(
      () => accountModule.getGamesUserInfoUseCaseFactory(
        gh<_i128.AccountRepository>(),
      ),
    );
    gh.factory<_i331.SettingsButtonBloc>(
      () => settingsButtonModule.appBarBlocFactory(gh<_i5.IRouter>()),
    );
    gh.factory<_i108.NoAdsButtonBloc>(
      () => noAdsButtonModule.appBarBlocFactory(gh<_i5.IRouter>()),
    );
    gh.factory<_i1028.CoinsBloc>(
      () => coinsModule.appBarBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i548.GetGamesUserInfoUseCase>(),
      ),
    );
    gh.factory<_i226.SettingsBloc>(
      () => settingsModule.appBarBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i937.GetGamesSettingsUseCase>(),
        gh<_i875.SetGamesSettingsUseCase>(),
      ),
    );
    gh.factory<_i559.SAGGameBloc>(
      () => sAGGameModule.gameSetBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i287.GetSAGGameUseCase>(),
      ),
    );
    gh.factory<_i108.SignInBloc>(
      () => signInModule.signInBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i544.GoogleSignInUseCase>(),
        gh<_i810.AppleSignInUseCase>(),
        gh<_i974.AnonymousSignInUseCase>(),
      ),
    );
    gh.factory<_i409.Widget>(
      () => noAdsButtonModule.appBarWidgetFactory(gh<_i108.NoAdsButtonBloc>()),
      instanceName: 'noAdsButtonWidget',
    );
    gh.factory<_i553.SAGGameItemBloc>(
      () => scratchAndGuessModule.sagGameItemBlocFactory(
        gh<_i5.IRouter>(),
        gh<_i861.GetNetworkImageUseCase>(),
        gh<_i973.GetNetworkImageSizeUseCase>(),
        gh<_i937.GetGamesSettingsUseCase>(),
      ),
    );
    gh.factory<_i409.Widget>(
      () => settingsButtonModule.appBarWidgetFactory(
        gh<_i331.SettingsButtonBloc>(),
      ),
      instanceName: 'settingsButtonWidget',
    );
    gh.factory<_i409.Widget>(
      () => coinsModule.appBarWidgetFactory(gh<_i1028.CoinsBloc>()),
      instanceName: 'coinsWidget',
    );
    gh.factory<_i409.Widget>(
      () => settingsModule.appBarWidgetFactory(
        gh<_i226.SettingsBloc>(),
        gh<_i409.Widget>(instanceName: 'noAdsButtonWidget'),
      ),
      instanceName: 'settingsRouteWidget',
    );
    gh.factory<_i409.Widget>(
      () => signInModule.signInRouteWidgetFactory(gh<_i108.SignInBloc>()),
      instanceName: 'sign_inRouteWidget',
    );
    gh.factoryParam<_i409.Widget, _i815.SAGGameItem, dynamic>(
      (sagGameItem, _) => scratchAndGuessModule.sagGameItemRouteWidgetFactory(
        gh<_i553.SAGGameItemBloc>(),
        sagGameItem,
        gh<_i409.Widget>(instanceName: 'settingsButtonWidget'),
        gh<_i409.Widget>(instanceName: 'noAdsButtonWidget'),
      ),
      instanceName: 'sagGameItemRouteWidget',
    );
    gh.factory<_i409.PreferredSizeWidget>(
      () => appBarModule.appBarWidgetFactory(
        gh<_i686.AppBarBloc>(),
        gh<_i409.Widget>(instanceName: 'coinsWidget'),
        gh<_i409.Widget>(instanceName: 'settingsButtonWidget'),
        gh<_i409.Widget>(instanceName: 'noAdsButtonWidget'),
      ),
      instanceName: 'appBarWidget',
    );
    gh.factoryParam<_i409.Widget, String, dynamic>(
      (id, _) => sAGGameModule.gameSetRouteWidgetFactory(
        gh<_i559.SAGGameBloc>(),
        id,
        gh<_i409.PreferredSizeWidget>(instanceName: 'appBarWidget'),
      ),
      instanceName: 'sagGameRouteWidget',
    );
    gh.factory<_i409.Widget>(
      () => sAGGamesModule.sagGamesRouteWidgetFactory(
        gh<_i1050.SAGGamesBloc>(),
        gh<_i409.PreferredSizeWidget>(instanceName: 'appBarWidget'),
      ),
      instanceName: 'sagGamesRouteWidget',
    );
    return this;
  }
}

class _$Global extends _i994.Global {}

class _$AppModule extends _i1048.AppModule {}

class _$SignInModule extends _i945.SignInModule {}

class _$AppBarModule extends _i591.AppBarModule {}

class _$SAGGameModule extends _i166.SAGGameModule {}

class _$FirebaseModule extends _i932.FirebaseModule {}

class _$SAGGamesModule extends _i333.SAGGamesModule {}

class _$NavModule extends _i750.NavModule {}

class _$AccountModule extends _i550.AccountModule {}

class _$SettingsButtonModule extends _i1025.SettingsButtonModule {}

class _$NoAdsButtonModule extends _i986.NoAdsButtonModule {}

class _$CoinsModule extends _i455.CoinsModule {}

class _$SettingsModule extends _i962.SettingsModule {}

class _$ScratchAndGuessModule extends _i77.ScratchAndGuessModule {}
