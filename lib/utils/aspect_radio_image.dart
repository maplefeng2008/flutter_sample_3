import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

typedef AsyncImageWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot, String url);

typedef AsyncImageFileWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot, File file);

typedef AsyncImageMemoryWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot, Uint8List bytes);

enum AspectRadioImageType { NETWORK, FILE, ASSET, MEMORY }

///有宽高的Image
// ignore: must_be_immutable
class AspectRadioImage extends StatelessWidget {
  String? url;
  File? file;
  Uint8List? bytes;
  final ImageProvider provider;
  AspectRadioImageType type;
  late AsyncImageWidgetBuilder<ui.Image> builder;
  late AsyncImageFileWidgetBuilder<ui.Image> filebBuilder;
  late AsyncImageMemoryWidgetBuilder<ui.Image> memoryBuilder;

  AspectRadioImage.network(url, {Key? key, required this.builder})
      : provider = NetworkImage(url),
        type = AspectRadioImageType.NETWORK,
        this.url = url;

  AspectRadioImage.file(file, {Key? key, required this.filebBuilder,})  
      : provider = FileImage(file),
        type = AspectRadioImageType.FILE,
        this.file = file;

  AspectRadioImage.asset(name, {Key? key, required this.builder})
      : provider = AssetImage(name),
        type = AspectRadioImageType.ASSET,
        this.url = name;

  AspectRadioImage.memory(bytes, {Key? key, required this.memoryBuilder})
      : provider = MemoryImage(bytes),
        type = AspectRadioImageType.MEMORY,
        this.bytes = bytes;

  @override
  Widget build(BuildContext context) {
    final ImageConfiguration config = createLocalImageConfiguration(context);
    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ImageStream stream = provider.resolve(config);
    ImageStreamListener? listener;

    listener = ImageStreamListener((ImageInfo image, bool sync) {
        completer.complete(image.image);
        stream.removeListener(listener!);
      },
      onError: (Object exception, StackTrace? stackTrace) {
        completer.complete();
        stream.removeListener(listener!);
        FlutterError.reportError(FlutterErrorDetails(
          context: ErrorDescription('image failed to precache'),
          library: 'image resource service',
          exception: exception,
          stack: stackTrace,
          silent: true,
        ));
      },
    );
    stream.addListener(listener);

    return FutureBuilder(
      future: completer.future,
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        if (snapshot.hasData) {
          if (type == AspectRadioImageType.FILE) {
            return filebBuilder(context, snapshot, file!);
          } else if (type == AspectRadioImageType.MEMORY) {
            return memoryBuilder(context, snapshot, bytes!);
          } else {
            return builder(context, snapshot, url!);
          }
        } else {
          return Container();
        }
      }
    );
  }
}
