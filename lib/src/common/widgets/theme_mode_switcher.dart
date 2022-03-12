import 'package:flutter/material.dart';
import 'package:utopic_slide_puzzle/l10n/generated/l10n.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/dynamic_theme_mode.dart';

/// {@template theme_mode_switcher}
/// A switcher that shows current theme mode and changes it. Handled by [DynamicThemeMode] widget
/// {@endtemplate}
class ThemeModeSwitcher extends StatelessWidget {
  /// {@macro theme_mode_switcher}
  const ThemeModeSwitcher({Key? key}) : super(key: key);

  String _translateThemeMode(BuildContext context, ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return Dictums.of(context).systemDefaultThemeMode;
      case ThemeMode.light:
        return Dictums.of(context).lightThemeMode;
      case ThemeMode.dark:
        return Dictums.of(context).darkThemeMode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
      stream: DynamicThemeMode.of(context)?.themeModeController,
      builder: (context, themeModeSnapshot) {
        final themeMode = themeModeSnapshot.data;

        if (themeMode == null) {
          return Container();
        }

        return TooltipVisibility(
          visible: false,
          child: PopupMenuButton<ThemeMode>(
            initialValue: themeMode,
            itemBuilder: (context) => [
              for (var themeModeValue in ThemeMode.values)
                PopupMenuItem<ThemeMode>(
                  value: themeModeValue,
                  child: ListTile(
                    title: Text(_translateThemeMode(context, themeModeValue)),
                  ),
                ),
            ],
            onSelected: (newThemeMode) {
              DynamicThemeMode.of(context)?.setThemeMode(newThemeMode);
            },
            child: ListTile(
              iconColor: Theme.of(context).iconTheme.color,
              leading: const Icon(Icons.color_lens_rounded),
              title: Text(Dictums.of(context).themeModeSwitcherTitle),
              subtitle: Text(_translateThemeMode(context, themeMode)),
            ),
          ),
        );
      },
    );
  }
}
