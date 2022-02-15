import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._();

  /// Singleton instance of [LocalStorageService]
  static final LocalStorageService instance = LocalStorageService._();

  Future writeCurrentPuzzleLevel(int puzzleLevelIndex) async {
    final _sharedPrefsStorage = await SharedPreferences.getInstance();
    await _sharedPrefsStorage.setInt('currentPuzzleLevelIndex', puzzleLevelIndex);
  }
}