import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

Future<img.BitmapFont> loadBMFont() async {
  final fontFile = await rootBundle.loadString('assets/fonts/ArialNow.fnt');
  final fontImage = await rootBundle.load('assets/fonts/ArialNow_0.png');

  // Decode the font texture
  final img.Image fontTexture =
      img.decodeImage(fontImage.buffer.asUint8List())!;

  // Create a bitmap font
  return img.BitmapFont.fromFnt(fontFile, fontTexture);
}
