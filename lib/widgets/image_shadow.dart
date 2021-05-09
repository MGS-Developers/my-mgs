import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageShadow extends StatelessWidget {
  final Widget child;
  final String? imageUrl;

  final double shadowSize;
  final double spacing;
  const ImageShadow({
    required this.child,
    this.imageUrl,
    this.shadowSize = 8.0,
    this.spacing = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final _url = imageUrl;

    return Stack(
      children: [
        Positioned.fill(
          top: spacing,
          child: ClipRect(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing * 2).copyWith(bottom: spacing * 2),
              child: Stack(
                children: [
                  if (_url != null) Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: _url,
                      fit: BoxFit.cover,
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: shadowSize, sigmaY: shadowSize),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            )
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: spacing * 2),
          child: child,
        ),
      ],
    );
  }
}
