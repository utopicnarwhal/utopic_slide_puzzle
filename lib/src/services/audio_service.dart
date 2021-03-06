import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:utopic_slide_puzzle/src/models/tile.dart';
import 'package:utopic_slide_puzzle/src/services/local_storage.dart';

Map<int, String> _tileValueAssetSoundFileMap = {
  1: 'B3.mp3',
  2: 'C4.mp3',
  3: 'D4.mp3',
  4: 'E4.mp3',
  5: 'F4.mp3',
  6: 'G4.mp3',
  7: 'A4.mp3',
  8: 'B4.mp3',
  9: 'C5.mp3',
  10: 'D5.mp3',
  11: 'E5.mp3',
  12: 'F5.mp3',
  13: 'G5.mp3',
  14: 'A5.mp3',
  15: 'B5.mp3',
};

/// Audio service of the app that handles all the audio output
class AudioService {
  AudioService._();

  /// Singleton instance of [AudioService]
  static final AudioService instance = AudioService._();

  final _tileMoveAudioPlayer = AudioPlayer();

  /// Loads the saved volume from the [LocalStorageService]
  Future init() {
    return LocalStorageService.readCurrentSoundFXVolume().then<dynamic>(setVolumeForFx);
  }

  /// Sets sound volume for the all available SoundFX audio players
  Future setVolumeForFx(double volume) {
    return _tileMoveAudioPlayer.setVolume(volume);
  }

  /// Plays the sound of moving tile
  Future playTileMoveSound(Tile tile, Duration delay, {bool isPianoLevel = false}) async {
    if (_tileMoveAudioPlayer.volume == 0) {
      return;
    }
    await _tileMoveAudioPlayer.pause();

    Future setAssetFuture;
    if (isPianoLevel && _tileValueAssetSoundFileMap[tile.value] != null) {
      // ignore: unawaited_futures
      setAssetFuture = _tileMoveAudioPlayer.setAsset('assets/sound_fx/${_tileValueAssetSoundFileMap[tile.value]}');
    } else {
      // ignore: unawaited_futures
      setAssetFuture = _tileMoveAudioPlayer.setAsset('assets/sound_fx/tile_move_sound.mp3');
    }

    try {
      await setAssetFuture;
      Future<dynamic>.delayed(delay, () async {
        await _tileMoveAudioPlayer.seek(Duration.zero);
        await _tileMoveAudioPlayer.play();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
