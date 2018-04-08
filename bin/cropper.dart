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


void main(List<String> arguments) {
    if (arguments.length != 1) {
        Io.stderr.writeln('Usage:\n\tdart cropper.dart <pano-to-crop>');
        Io.exit(2);
    }

    String imagePath = arguments[0];
    if (!Io.FileSystemEntity.isFileSync(imagePath)) {
        Io.stderr.writeln('File $imagePath does not exist');
        Io.exit(2);
    }

    Image image = decodeImage(new Io.File(imagePath).readAsBytesSync());

    if (!canCropImage(image)) {
        Io.stderr.writeln('To crop pano, its width should be at least twice of its height');
        Io.exit(2);
    }

    List<Image> slices = slice(image);

    for (int piece = 0; piece < slices.length; piece++) {
        new Io.File('${imagePath}.${piece}.jpg')
        ..writeAsBytesSync(encodeJpg(slices[piece]));
    }
}
