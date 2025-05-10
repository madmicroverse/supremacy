import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/result.dart';

part 'app_wrapper_bs.freezed.dart';

@freezed
abstract class AppWrapperBS with _$AppWrapperBS {
  const factory AppWrapperBS({AppWrapperError? appWrapperError}) =
      _AppWrapperBS;
}

extension AppWrapperBSStateMutations on AppWrapperBS {
  AppWrapperBS withAppWrapperError(AppWrapperError appWrapperError) =>
      copyWith(appWrapperError: appWrapperError);

  AppWrapperBS get withoutAppWrapperError => copyWith(appWrapperError: null);
}

extension AppWrapperBSStateQueries on AppWrapperBS {
  bool get isAppWrapperNoInternetError =>
      appWrapperError is AppWrapperNoInternetError;
}

sealed class AppWrapperError extends BaseError {}

class AppWrapperNoInternetError extends AppWrapperError {}
