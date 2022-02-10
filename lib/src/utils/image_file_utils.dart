// ignore_for_file: public_member_api_docs
// TODO(sergei): Add docs

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

abstract class ImageFileUtils {
  static Future<ui.Image?> resizeImage(Uint8List? fileData, {int targetWidth = 864, int targetHeight = 864}) async {
    if (fileData == null) {
      return null;
    }
    final codec = await ui.instantiateImageCodec(fileData, targetWidth: targetWidth, targetHeight: targetHeight);
    final frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}
