import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sag_game_item_be.dart';
import '../bloc/sag_game_item_bloc.dart';

extension ContextBloc on BuildContext {
  SAGGameItemBloc get bloc => read<SAGGameItemBloc>();

  addEvent(SAGGameItemBE coinsBE) => bloc.add(coinsBE);
}
