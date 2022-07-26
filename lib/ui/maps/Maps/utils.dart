import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

Future<Uint8List> readNetworkImage(String imageUrl, int width) async {
  final ByteData data =
      await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();

  // final Int8List bytes = (data.buffer.asInt8List());
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
