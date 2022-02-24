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
}

class AppLocalizationDelegate extends LocalizationsDelegate<Dictums> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
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
