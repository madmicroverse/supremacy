import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/upsert_sag_game_selection_operation.dart';
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
const sagGamesTopRouteName = "sagGamesTopRouteName";
const sagGamesEventRouteName = "sagGamesEventRouteName";
const sagGamesReplyRouteName = "sagGamesReplyRouteName";
const sagGamesSelectionRouteName = "sagGamesSelectionRouteName";
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
    @Named(sagGamesSelectionRouteName) GoRoute sagGamesSelectionRoute,
    @Named(sagGamesMainRouteName) GoRoute sagGamesMainRoute,
    @Named(sagGamesTopRouteName) GoRoute sagGamesTopRoute,
    @Named(sagGamesEventRouteName) GoRoute sagGamesEventRoute,
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
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
      routes: [
        sagGamesSelectionRoute,
        sagGamesReplyRoute,
        sagGamesMainRoute,
        sagGamesTopRoute,
        sagGamesEventRoute,
      ],
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
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }

  @Injectable()
  @Named(sagGamesSelectionRouteName)
  GoRoute sagGamesSelectionRouteFactory() {
    return GoRoute(
      path: sagGamesSelectionRouteName.rootPath,
      name: sagGamesSelectionRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GetIt.instance.get<Widget>(
            instanceName: sagGamesRouteWidget,
            param1: LiveSAGGameSource.favorites,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }

  @Injectable()
  @Named(sagGamesTopRouteName)
  GoRoute sagGamesTopRouteFactory() {
    return GoRoute(
      path: sagGamesTopRouteName.rootPath,
      name: sagGamesTopRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GetIt.instance.get<Widget>(
            instanceName: sagGamesRouteWidget,
            param1: LiveSAGGameSource.top,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }

  @Injectable()
  @Named(sagGamesEventRouteName)
  GoRoute sagGamesEventRouteFactory() {
    return GoRoute(
      path: sagGamesEventRouteName.rootPath,
      name: sagGamesEventRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GetIt.instance.get<Widget>(
            instanceName: sagGamesRouteWidget,
            param1: LiveSAGGameSource.event,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }
}
