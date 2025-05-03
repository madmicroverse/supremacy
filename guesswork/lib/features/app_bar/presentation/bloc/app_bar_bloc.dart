import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';

import 'app_bar_be.dart';
import 'app_bar_bsc.dart';

class AppBarBloc extends Bloc<AppBarBE, BlocState<AppBarBSC>> {
  AppBarBloc()
    : super(
        BlocState<AppBarBSC>(
          status: LoadingStateStatus(),
          content: AppBarBSC(),
        ),
      );
}
