import 'package:get_it/get_it.dart';
import 'package:guesswork/di/di.config.dart';
import 'package:injectable/injectable.dart';

const env = String.fromEnvironment('env', defaultValue: 'stage');

@InjectableInit(generateForDir: ['lib/di', 'lib/features/**/di'])
Future<GetIt> configureDependencies() async {
  return GetIt.instance.init(environment: env);
}
