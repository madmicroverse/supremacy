import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';
import 'package:guesswork/features/settings_button/presentation/bloc/settings_button_be.dart';

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
    return BlocBuilder<SettingsButtonBloc, BlocState<SettingsButtonBSC>>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => context.addEvent(ShowSettingsBE()),
          icon: const Icon(Icons.settings, size: 28, color: Colors.blueGrey),
        );
      },
    );
  }
}
