import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:guesswork/core/data/framework/firebase/signed_status.dart';
import 'package:guesswork/core/data/framework/router_impl.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/extension/route_name_extension.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/repository/auth_repository.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/di/sag_game_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game_home/di/sag_game_home_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game_item/di/sag_game_item_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_games/di/sag_games_module.dart';
import 'package:guesswork/fragments/standalone/settings/di/settings_module.dart';
import 'package:guesswork/fragments/standalone/sign_in/di/sign_in_module.dart';
import 'package:injectable/injectable.dart';

const signInRouteName = "signInRouteName";
const sagGamesHomeRouteName = "sagGamesHomeRouteName";

const sagGamesMainRouteName = "sagGamesMainRouteName";
const sagGamesReplyRouteName = "sagGamesReplyRouteName";
const sagGamesFavoriteRouteName = "sagGamesFavoriteRouteName";
const sagGameItemRouteName = "sagGameItemRouteName";
const sagGameRouteName = "sagGameRouteName";
const settingsRouteName = "settingsRouteName";

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@module
abstract class NavModule {
  @preResolve
  @Singleton()
  Future<GoRouter> goRouterFactory(
    AuthRepository authRepository,
    @Named(signInRouteName) GoRoute signInRoute,
    @Named(sagGamesHomeRouteName) ShellRoute sagGamesHomeRoute,
    @Named(sagGameRouteName) GoRoute sagGameRoute,
    @Named(sagGameItemRouteName) GoRoute sagGameItemRoute,
    @Named(settingsRouteName) GoRoute settingsRoute,
  ) async {
    late String initialLocation;
    dynamic initialExtra;
    final result = authRepository.getAuthStatus();
    switch (result) {
      case Success():
        switch (result.data) {
          case Authenticated():
            initialLocation = sagGamesMainRouteName.rootPath;
          case Unauthenticated():
            initialLocation = signInRoute.path;
        }
      default:
        initialLocation = signInRoute.path;
    }

    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: initialLocation,
      initialExtra: initialExtra,
      routes: [
        sagGamesHomeRoute,
        sagGameRoute,
        sagGameItemRoute,
        signInRoute,
        settingsRoute,
      ],
    );
  }

  @Singleton()
  IRouter router(GoRouter goRouter) => RouterImpl(goRouter);

  @Injectable()
  @Named(signInRouteName)
  GoRoute signInRouteFactory() {
    return GoRoute(
      path: signInRouteName.rootPath,
      name: signInRouteName,
      builder: (context, state) {
        return GetIt.instance.get<Widget>(instanceName: signInWidget);
      },
    );
  }

  @Injectable()
  @Named(sagGamesHomeRouteName)
  ShellRoute sagGamesHomeRouteFactory(
    @Named(sagGamesFavoriteRouteName) GoRoute sagGamesFavoriteRoute,
    @Named(sagGamesMainRouteName) GoRoute sagGamesMainRoute,
    @Named(sagGamesReplyRouteName) GoRoute sagGamesReplyRoute,
  ) {
    return ShellRoute(
      pageBuilder: (context, state, child) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GetIt.instance.get<Widget>(
            instanceName: sagGameHomeRoutWidget,
            param1: child,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Create your custom transition here
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
      routes: [sagGamesFavoriteRoute, sagGamesReplyRoute, sagGamesMainRoute],
    );
  }

  @Injectable()
  @Named(sagGamesReplyRouteName)
  GoRoute sagGamesReplyRouteFactory() {
    return GoRoute(
      path: sagGamesReplyRouteName.rootPath,
      name: sagGamesReplyRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GetIt.instance.get<Widget>(
            instanceName: sagGamesRouteWidget,
            param1: SAGGameSource.replay,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Create your custom transition here
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }

  @Injectable()
  @Named(sagGamesFavoriteRouteName)
  GoRoute sagGamesFavoriteRouteFactory() {
    return GoRoute(
      path: sagGamesFavoriteRouteName.rootPath,
      name: sagGamesFavoriteRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GetIt.instance.get<Widget>(
            instanceName: sagGamesRouteWidget,
            param1: SAGGameSource.favorite,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Create your custom transition here
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }

  @Injectable()
  @Named(sagGamesMainRouteName)
  GoRoute sagGamesMainRouteFactory() {
    return GoRoute(
      path: sagGamesMainRouteName.rootPath,
      name: sagGamesMainRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GetIt.instance.get<Widget>(
            instanceName: sagGamesRouteWidget,
            param1: SAGGameSource.main,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Create your custom transition here
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }

  @Injectable()
  @Named(sagGameRouteName)
  GoRoute sagGameRouteFactory() {
    return GoRoute(
      path: sagGameRouteName.rootPath,
      name: sagGameRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GetIt.instance.get<Widget>(
            instanceName: sagGameRouteWidget,
            param1: state.extra,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Create your custom transition here
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }

  @Injectable()
  @Named(sagGameItemRouteName)
  GoRoute sagGameItemRouteFactory() {
    return GoRoute(
      path: sagGameItemRouteName.rootPath,
      name: sagGameItemRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GetIt.instance.get<Widget>(
            instanceName: sagGameItemRouteWidget,
            param1: state.extra,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Create your custom transition here
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }

  @Injectable()
  @Named(settingsRouteName)
  GoRoute settingsRouteFactory() {
    return GoRoute(
      path: settingsRouteName.rootPath,
      name: settingsRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GetIt.instance.get<Widget>(
            instanceName: settingsRouteWidget,
            param1: state.extra,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Create your custom transition here
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }
}
