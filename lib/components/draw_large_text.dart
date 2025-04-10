// import 'dart:typed_data';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:image/image.dart' as img;

// Future<img.Image> drawCustomTextOnImage({
//   required img.Image baseImage,
//   required String text,
//   required String fontAssetPath,
//   required int charWidth,
//   required int charHeight,
//   required int startCharCode, // e.g. 65 for 'A'
// }) async {
//   // Load font image
//   final fontBytes = await rootBundle.load(fontAssetPath);
//   final fontImage = img.decodeImage(fontBytes.buffer.asUint8List());
//   if (fontImage == null) throw Exception("Failed to decode font image");

//   // Draw each character
//   int x = 10;
//   int y = baseImage.height - charHeight - 10;

//   for (int i = 0; i < text.length; i++) {
//     int code = text.codeUnitAt(i);

//     // Skip unsupported chars
//     if (code < startCharCode || code >= startCharCode + 26) continue;

//     int index = code - startCharCode;
//     int srcX = index * charWidth;

//     final charImage = img.copyCrop(fontImage, srcX, 0, charWidth, charHeight);
//     img.copyInto(baseImage, charImage, dstX: x, dstY: y);

//     x += charWidth;
//   }

//   return baseImage;
// }
