
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:screen_s1ze/theme/theme_cubit.dart';

class MySettingsScreen extends StatelessWidget {
  const MySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: 'Settings',
      children: [
        SwitchSettingsTile(
          settingKey: 'dark-mode',
          title: 'Dark Mode',
          enabledLabel: 'Enabled',
          disabledLabel: 'Disabled',
          leading: const Icon(Icons.nightlight_round),
          onChange: (value) {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
      ],
    );
  }
}
