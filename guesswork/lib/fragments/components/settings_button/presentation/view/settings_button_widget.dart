import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';

import '../bloc/settings_button_be.dart';
import '../bloc/settings_button_bloc.dart';
import '../bloc/settings_button_bsc.dart';

extension ContextBloc on BuildContext {
  SettingsButtonBloc get bloc => read<SettingsButtonBloc>();

  addEvent(SettingsButtonBE settingsButtonBE) => bloc.add(settingsButtonBE);
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsButtonBloc, SettingsButtonBSC>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => context.addEvent(ShowSettingsBE()),
          icon: Icon(
            Icons.settings,
            size: 28,
            color: context.colorScheme.primary,
          ),
        );
      },
    );
  }
}
