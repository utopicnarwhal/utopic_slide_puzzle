// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Dictums {
  Dictums();

  static Dictums? _current;

  static Dictums get current {
    assert(_current != null,
        'No instance of Dictums was loaded. Try to initialize the Dictums delegate before accessing Dictums.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Dictums> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Dictums();
      Dictums._current = instance;

      return instance;
    });
  }

  static Dictums of(BuildContext context) {
    final instance = Dictums.maybeOf(context);
    assert(instance != null,
        'No instance of Dictums present in the widget tree. Did you add Dictums.delegate in localizationsDelegates?');
    return instance!;
  }

  static Dictums? maybeOf(BuildContext context) {
    return Localizations.of<Dictums>(context, Dictums);
  }

  /// `Page not found`
  String get pageNotFound {
    return Intl.message(
      'Page not found',
      name: 'pageNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Shuffle`
  String get shuffleButtonText {
    return Intl.message(
      'Shuffle',
      name: 'shuffleButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Puzzle Solved`
  String get puzzleSolved {
    return Intl.message(
      'Puzzle Solved',
      name: 'puzzleSolved',
      desc: '',
      args: [],
    );
  }

  /// `Utopic Slide Puzzle`
  String get puzzleChallengeTitle {
    return Intl.message(
      'Utopic Slide Puzzle',
      name: 'puzzleChallengeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Moves`
  String get puzzleNumberOfMoves {
    return Intl.message(
      'Moves',
      name: 'puzzleNumberOfMoves',
      desc: '',
      args: [],
    );
  }

  /// `Tiles left`
  String get puzzleNumberOfTilesLeft {
    return Intl.message(
      'Tiles left',
      name: 'puzzleNumberOfTilesLeft',
      desc: '',
      args: [],
    );
  }

  /// `Next level`
  String get nextLevelButtonLabel {
    return Intl.message(
      'Next level',
      name: 'nextLevelButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Image reference`
  String get imageReference {
    return Intl.message(
      'Image reference',
      name: 'imageReference',
      desc: '',
      args: [],
    );
  }

  /// `You can use also:`
  String get additionalControlOptionsTitle {
    return Intl.message(
      'You can use also:',
      name: 'additionalControlOptionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hm...`
  String get proposeToSolveDialogTitle {
    return Intl.message(
      'Hm...',
      name: 'proposeToSolveDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Seems like you are in rage. Do you want I'll solve this puzzle for you?`
  String get proposeToSolveDialogBody {
    return Intl.message(
      'Seems like you are in rage. Do you want I\'ll solve this puzzle for you?',
      name: 'proposeToSolveDialogBody',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Resume`
  String get mainMenuResumeButton {
    return Intl.message(
      'Resume',
      name: 'mainMenuResumeButton',
      desc: '',
      args: [],
    );
  }

  /// `Licenses`
  String get mainMenuLicensesButton {
    return Intl.message(
      'Licenses',
      name: 'mainMenuLicensesButton',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get mainMenuAboutTheAppButton {
    return Intl.message(
      'About the app',
      name: 'mainMenuAboutTheAppButton',
      desc: '',
      args: [],
    );
  }

  /// `Sound volume`
  String get mainMenuSoundVolumeSliderLabel {
    return Intl.message(
      'Sound volume',
      name: 'mainMenuSoundVolumeSliderLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select level`
  String get mainMenuSelectLevelButton {
    return Intl.message(
      'Select level',
      name: 'mainMenuSelectLevelButton',
      desc: '',
      args: [],
    );
  }

  /// `Paused`
  String get mainMenuDialogTitle {
    return Intl.message(
      'Paused',
      name: 'mainMenuDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `System default`
  String get systemDefaultThemeMode {
    return Intl.message(
      'System default',
      name: 'systemDefaultThemeMode',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get lightThemeMode {
    return Intl.message(
      'Light',
      name: 'lightThemeMode',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get darkThemeMode {
    return Intl.message(
      'Dark',
      name: 'darkThemeMode',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get themeModeSwitcherTitle {
    return Intl.message(
      'Appearance',
      name: 'themeModeSwitcherTitle',
      desc: '',
      args: [],
    );
  }

  /// `Level selection`
  String get levelSelectionDialogTitle {
    return Intl.message(
      'Level selection',
      name: 'levelSelectionDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get appVersionTitle {
    return Intl.message(
      'Version',
      name: 'appVersionTitle',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get aboutTheAppDialogTitle {
    return Intl.message(
      'About the app',
      name: 'aboutTheAppDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Developer`
  String get developerNameHeadline {
    return Intl.message(
      'Developer',
      name: 'developerNameHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Cannot open url`
  String get cannotOpenUrl {
    return Intl.message(
      'Cannot open url',
      name: 'cannotOpenUrl',
      desc: '',
      args: [],
    );
  }

  /// `Source code repository`
  String get sourceCodeRepository {
    return Intl.message(
      'Source code repository',
      name: 'sourceCodeRepository',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for playing!`
  String get thanksForPlayingDialogTitle {
    return Intl.message(
      'Thanks for playing!',
      name: 'thanksForPlayingDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Well done! Hopefully you liked it.`
  String get thanksForPlayingMessagePart1 {
    return Intl.message(
      'Well done! Hopefully you liked it.',
      name: 'thanksForPlayingMessagePart1',
      desc: '',
      args: [],
    );
  }

  /// `If you would like to try to solve some level again — you can select it in the main menu.`
  String get thanksForPlayingMessagePart2 {
    return Intl.message(
      'If you would like to try to solve some level again — you can select it in the main menu.',
      name: 'thanksForPlayingMessagePart2',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menuButtonLabel {
    return Intl.message(
      'Menu',
      name: 'menuButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Level {levelNumber}`
  String levelNumberIndicator(Object levelNumber) {
    return Intl.message(
      'Level $levelNumber',
      name: 'levelNumberIndicator',
      desc: '',
      args: [levelNumber],
    );
  }

  /// `Upload custom image`
  String get uploadCustomImageButtonLabel {
    return Intl.message(
      'Upload custom image',
      name: 'uploadCustomImageButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Only .png and .jpg formats supported`
  String get onlyPngAndJpgFormatsSupported {
    return Intl.message(
      'Only .png and .jpg formats supported',
      name: 'onlyPngAndJpgFormatsSupported',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Dictums> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Dictums> load(Locale locale) => Dictums.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
