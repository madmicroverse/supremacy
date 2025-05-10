import 'package:guesswork/fragments/standalone/app_wrapper/presentation/bloc/app_wrapper_bs.dart';

sealed class AppWrapperBE {}

class InitAppWrapperBE extends AppWrapperBE {}

class ErrorBE extends AppWrapperBE {
  AppWrapperError appWrapperError;

  ErrorBE(this.appWrapperError);
}

class NoErrorBE extends AppWrapperBE {}
