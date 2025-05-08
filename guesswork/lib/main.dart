import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /**
   * Injectable
   * Keep an eye on the time the DI setup take, should be as minimal as possible
   */
  await configureDependencies();

  runApp(GetIt.instance<MaterialApp>());
}
