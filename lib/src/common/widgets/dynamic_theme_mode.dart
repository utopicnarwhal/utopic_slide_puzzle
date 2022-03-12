import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template dynamic_theme_mode}
/// Manages current app's [ThemeMode] with [SharedPreferences].
///
/// Usually this widget should be upper then [MaterialApp] in a widget tree so
/// the `themeMode` value can be passed into it.
///
/// Use [DynamicThemeModeState.setThemeMode] to set new theme mode.
/// Listen to [DynamicThemeModeState.themeModeController] to get current theme mode and updates
/// {@endtemplate}
class DynamicThemeMode extends StatefulWidget {
  /// {@macro dynamic_theme_mode}
  const DynamicThemeMode({
    required this.builder,
    this.defaultThemeMode = ThemeMode.system,
    Key? key,
  }) : super(key: key);

  /// The child builder widget.
  ///
  /// It is common to give the root [MaterialApp] to pass the themeMode into it
  final Widget Function(BuildContext context, ThemeMode themeMode) builder;

  /// Default [ThemeMode] to use at first time the app starts
  final ThemeMode defaultThemeMode;

  @override
  DynamicThemeModeState createState() => DynamicThemeModeState();

  /// The data from the closest [DynamicThemeMode] instance that encloses the given context.
  static DynamicThemeModeState? of(BuildContext context) {
    return context.findAncestorStateOfType<DynamicThemeModeState>();
  }
}

/// Widget state class of the [DynamicThemeMode] widget
class DynamicThemeModeState extends State<DynamicThemeMode> {
  static const String _sharedPreferencesKey = 'themeMode';

  /// Listen to this [BehaviorSubject] to get the value and updates of the current theme mode
  late BehaviorSubject<ThemeMode> themeModeController;

  @override
  void initState() {
    super.initState();
    themeModeController = BehaviorSubject.seeded(widget.defaultThemeMode);

    _loadThemeMode().then((themeMode) {
      if (mounted) themeModeController.add(themeMode);
    });
  }

  @override
  void dispose() {
    themeModeController.close();
    super.dispose();
  }

  /// Changes the theme mode value to return in builder and stores [newThemeMode]
  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    themeModeController.add(newThemeMode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sharedPreferencesKey, newThemeMode.index);
  }

  Future<ThemeMode> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    var themeModeIndex = prefs.getInt(_sharedPreferencesKey);
    if (themeModeIndex == null || themeModeIndex >= ThemeMode.values.length) {
      themeModeIndex = widget.defaultThemeMode.index;
    }
    return ThemeMode.values.elementAt(themeModeIndex);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
      stream: themeModeController,
      builder: (context, themeModeSnapshot) => widget.builder(context, themeModeSnapshot.data ?? ThemeMode.system),
    );
  }
}
