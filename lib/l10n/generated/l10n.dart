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