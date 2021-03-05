import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/image.dart';

ImageProvider? nullableImageProvider({
  String? url,
  MGSImage? image,
}) {
  final _url = url ?? image?.fullUrl ?? image?.thumbnailUrl;
  if (_url == null) {
    return null;
  } else {
    return CachedNetworkImageProvider(_url);
  }
}

class NullableImage extends StatelessWidget {
  final String? url;
  final MGSImage? image;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const NullableImage({
    this.url,
    this.image,
    this.fit,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (url != null || image != null) {
      return Image(
        fit: fit,
        image: nullableImageProvider(url: url, image: image)!,
        width: width,
        height: height,
      );
    } else {
      return SizedBox(
        width: width,
        height: height,
      );
    }
  }
}
