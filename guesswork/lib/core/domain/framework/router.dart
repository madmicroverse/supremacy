abstract class IRouter {
  bool canPop();

  void goNamed(
    String name, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  });

  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  });

  Future<T?> replaceNamed<T>(
    String name, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  });

  void pop<T extends Object?>([T? result]);

  Uri get uri;

  bool isOn(String routeName);
}
