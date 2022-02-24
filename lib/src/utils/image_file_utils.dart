import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

/// Abstract class that contains util methods related to image file
abstract class ImageFileUtils {
  /// Converts [fileData] bytes to the [ui.Image] object
  ///
  /// The [targetWidth] and [targetHeight] arguments specify the size of the output image, in image pixels
  static Future<ui.Image?> resizeImage(Uint8List? fileData, {int targetWidth = 864, int targetHeight = 864}) async {
    if (fileData == null) {
      return null;
    }
    final codec = await ui.instantiateImageCodec(fileData, targetWidth: targetWidth, targetHeight: targetHeight);
    final frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}
