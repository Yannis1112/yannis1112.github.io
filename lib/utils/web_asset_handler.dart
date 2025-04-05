import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class AssetHandler {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter/assets',
      const StandardMethodCodec(),
      registrar,
    );

    channel.setMethodCallHandler((call) async {
      if (call.method == 'loadAsset') {
        final String assetPath = call.arguments;
        ByteData data = await rootBundle.load(assetPath);
        return data.buffer.asUint8List();
      }
      return null;
    });
  }
}