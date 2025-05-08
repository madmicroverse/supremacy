import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/core/presentation/extension/localozations.dart';
import 'package:guesswork/core/presentation/widgets/space.dart';

import '../bloc/settings_be.dart';
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
        title: Text(context.loc.setting_title),
        actions: [noAdsButton],
      ),
      body: BlocBuilder<SettingsBloc, SettingsBSC>(
        builder: (context, state) {
          if (state.isGameSettingsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final gameSettings = state.gameSettings!;
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            children: [
              ListTile(
                title: Text(
                  context.loc.setting_games_preferences,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ListTile(
                leading: Icon(Icons.volume_down_alt),
                title: Text(context.loc.setting_games_preferences_sound),
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
                title: Text(context.loc.setting_games_preferences_music),
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
                title: Text(context.loc.setting_games_preferences_haptic),
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
                onTap: () => context.addEvent(SignOutBE()),
                leading: Icon(Icons.logout),
                title: Text(context.loc.setting_sign_out),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
              vsMax,
              ListTile(
                title: Text(
                  context.loc.setting_information,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.mail),
                title: Text(context.loc.setting_contact_us),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
              vsMax,
              if (state.version.isNotNull)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      context.loc.settings_app_version(state.version!),
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
                      context.loc.setting_privacy_policies,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      context.loc.setting_terms_of_service,
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
