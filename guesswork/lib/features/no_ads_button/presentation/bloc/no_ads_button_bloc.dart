import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';

import 'no_ads_button_be.dart';
import 'no_ads_button_bsc.dart';

class NoAdsButtonBloc
    extends Bloc<NoAdsButtonBE, BlocState<NoAdsButtonBSC>> {
  final IRouter _router;

  NoAdsButtonBloc(this._router)
    : super(
        BlocState<NoAdsButtonBSC>(
          status: IdleStateStatus(),
          content: NoAdsButtonBSC(),
        ),
      ) {
    on<ShowNoAdsBE>(_showNoAdsButtonBE);
  }

  FutureOr<void> _showNoAdsButtonBE(
    ShowNoAdsBE event,
    Emitter<BlocState<NoAdsButtonBSC>> emit,
  ) async {
    // TODO navigate to settings page when ready
  }
}
