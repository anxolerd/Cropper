import 'dart:io' as Io;
import 'package:image/image.dart';

bool canCropImage(Image image) {
    return image.width > 2 * image.height;
}

void main() {
    String imagePath = 'pano.jpg';
    Image image = decodeImage(new Io.File(imagePath).readAsBytesSync());

    if (!canCropImage(image)) {
        print('Cannot crop this image: its width is less then two heights');
        return;
    }
    
    int squareSize = image.height;
    int piece = 0;
    int piecesCount = image.width ~/ image.height + 1;
    List<Image> pieces = new List(piecesCount);

    for (int slice = 0; slice < image.width; slice += squareSize) {
        Image croppedPiece = copyCrop(image, slice, 0, squareSize, squareSize);
        pieces[piece++] = croppedPiece;
    }

    for (int piece = 0; piece < pieces.length; piece++) {
        new Io.File('pano-${piece}.jpg')
        ..writeAsBytesSync(encodeJpg(pieces[piece]));
    }
}
