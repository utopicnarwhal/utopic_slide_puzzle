import 'package:flutter/material.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/dynamic_theme_mode.dart';

/// {@template theme_mode_switcher}
/// A switcher that shows current theme mode and changes it. Handled by [DynamicThemeMode] widget
/// {@endtemplate}
class ThemeModeSwitcher extends StatelessWidget {
  /// {@macro theme_mode_switcher}
  const ThemeModeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
      stream: DynamicThemeMode.of(context)?.themeModeController,
      builder: (context, themeModeSnapshot) {
        final themeMode = themeModeSnapshot.data;

        if (themeMode == null) {
          return Container();
        }

        IconData icon;
        switch (themeMode) {
          case ThemeMode.system:
            icon = Icons.brightness_auto;
            break;
          case ThemeMode.light:
            icon = Icons.brightness_high;
            break;
          case ThemeMode.dark:
            icon = Icons.brightness_low;
            break;
        }
        return IconButton(
          icon: Icon(icon),
          onPressed: () {
            switch (themeMode) {
              case ThemeMode.system:
                DynamicThemeMode.of(context)?.setThemeMode(ThemeMode.light);
                break;
              case ThemeMode.light:
                DynamicThemeMode.of(context)?.setThemeMode(ThemeMode.dark);
                break;
              case ThemeMode.dark:
                DynamicThemeMode.of(context)?.setThemeMode(ThemeMode.system);
                break;
            }
          },
        );
      },
    );
  }
}
