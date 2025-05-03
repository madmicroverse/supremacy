import 'package:guesswork/core/domain/framework/router.dart';
import 'package:go_router/go_router.dart';

class RouterImpl extends IRouter {
  final GoRouter _goRouter;

  RouterImpl(this._goRouter);

  @override
  bool canPop() => _goRouter.canPop();

  @override
  void goNamed(
    String name, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) =>
      _goRouter.goNamed(
        name,
        extra: extra,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );

  @override
  void pop<T extends Object?>([T? result]) => _goRouter.pop(result);

  @override
  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) =>
      _goRouter.pushNamed<T>(
        name,
        extra: extra,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );

  @override
  Future<T?> replaceNamed<T>(
    String name, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) =>
      _goRouter.replaceNamed<T>(
        name,
        extra: extra,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );

  Uri get uri => _goRouter.routeInformationProvider.value.uri;

  @override
  bool isOn(String routeName) => uri.pathSegments.last == routeName;
}
