// ignore_for_file: public_member_api_docs

import 'package:shared_preferences/shared_preferences.dart';

/// Providing a persistent store for simple data
abstract class LocalStorageService {
  static Future writeCurrentPuzzleLevel(int puzzleLevelIndex) async {
    final _sharedPrefsStorage = await SharedPreferences.getInstance();
    await _sharedPrefsStorage.setInt('currentPuzzleLevelIndex', puzzleLevelIndex);
  }

  static Future<int> readCurrentPuzzleLevel() async {
    final _sharedPrefsStorage = await SharedPreferences.getInstance();
    return _sharedPrefsStorage.getInt('currentPuzzleLevelIndex') ?? 0;
  }

  static Future writeCurrentSoundFXVolume(double soundFXVolume) async {
    final _sharedPrefsStorage = await SharedPreferences.getInstance();
    await _sharedPrefsStorage.setDouble('currentSoundFXVolume', soundFXVolume);
  }

  static Future<double?> readCurrentSoundFXVolume() async {
    final _sharedPrefsStorage = await SharedPreferences.getInstance();
    return _sharedPrefsStorage.getDouble('currentSoundFXVolume');
  }
}
