import 'dart:io' as Io;

import 'package:image/image.dart';


List<Image> slice(Image image) {
    int sliceWidth = image.height;
    List<Image> slices = new List<Image>();

    for (int cut = 0; cut < image.width; cut += sliceWidth) {
        slices.add(copyCrop(image, cut, 0, sliceWidth, sliceWidth));
    }

    return slices;
}

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

    List<Image> slices = slice(image);

    for (int piece = 0; piece < slices.length; piece++) {
        new Io.File('pano-${piece}.jpg')
        ..writeAsBytesSync(encodeJpg(slices[piece]));
    }
}
