import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_bar_be.dart';
import 'app_bar_bsc.dart';

class AppBarBloc extends Bloc<AppBarBE, AppBarBSC> {
  AppBarBloc() : super(AppBarBSC());
}
