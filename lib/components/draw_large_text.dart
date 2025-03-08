import 'package:image/image.dart' as img;

void drawLargeText(
    img.Image image, String text, int x, int y, img.BitmapFont font) {
  for (int dx = -2; dx <= 2; dx++) {
    for (int dy = -2; dy <= 2; dy++) {
      img.drawString(image, text, font: font, x: x + dx, y: y + dy);
    }
  }
}
