import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/bloc_sate.dart';
import 'package:guesswork/core/presentation/widgets/space.dart';
import 'package:guesswork/features/settings/presentation/bloc/settings_be.dart';

import '../bloc/settings_bloc.dart';
import '../bloc/settings_bsc.dart';

extension ContextBloc on BuildContext {
  SettingsBloc get bloc => read<SettingsBloc>();

  addEvent(SettingsBE settingsBE) => bloc.add(settingsBE);
}

class Settings extends StatelessWidget {
  final Widget noAdsButton;

  const Settings({super.key, required this.noAdsButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
        actions: [noAdsButton],
      ),
      body: BlocBuilder<SettingsBloc, BlocState<SettingsBSC>>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final gameSettings = state.content.gameSettings!;
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            children: [
              ListTile(
                title: Text(
                  'Preferences',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ListTile(
                leading: Icon(Icons.volume_down_alt),
                title: Text('Sound'),
                trailing: Switch(
                  value: gameSettings.sound,
                  onChanged:
                      (newVal) => context.addEvent(
                        SwitchSettingsBE(gameSettings.copyWith(sound: newVal)),
                      ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Music'),
                trailing: Switch(
                  value: gameSettings.music,
                  onChanged:
                      (newVal) => context.addEvent(
                        SwitchSettingsBE(gameSettings.copyWith(music: newVal)),
                      ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.vibration),
                title: Text('haptic'),
                trailing: Switch(
                  value: gameSettings.haptic,
                  onChanged:
                      (newVal) => context.addEvent(
                        SwitchSettingsBE(gameSettings.copyWith(haptic: newVal)),
                      ),
                ),
              ),
              vsMax,
              ListTile(
                title: Text(
                  'Informacion',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.mail),
                title: Text('Contactanos'),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
              vsMax,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Version: 1020.3023.00',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              vsMin,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Politicas de privacidad',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Terminos de servicio',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
