import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/widgets/no_ad_icon_widget.dart';

import '../bloc/no_ads_button_be.dart';
import '../bloc/no_ads_button_bloc.dart';
import '../bloc/no_ads_button_bsc.dart';

extension ContextBloc on BuildContext {
  NoAdsButtonBloc get bloc => read<NoAdsButtonBloc>();

  addEvent(NoAdsButtonBE settingsButtonBE) => bloc.add(settingsButtonBE);
}

class NoAdsButton extends StatelessWidget {
  const NoAdsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoAdsButtonBloc, NoAdsButtonBSC>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => context.addEvent(ShowNoAdsBE()),
          icon: NoAdIconWidget(
            size: 28,
            iconColor: context.colorScheme.onPrimary,
          ),
        );
      },
    );
  }
}
