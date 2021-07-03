import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SizedShimmer extends StatelessWidget {
  final double width;
  final double height;

  const SizedShimmer({
    Key? key,
    this.width = double.infinity,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final baseColor = isDark ? Color(0xFF1A1A1A) : Color(0xFFE0E0E0);
    final highlightColor = isDark ? Color(0xFF3B3B3B) : Color(0xFFBABABA);

    return SizedBox(
      width: width,
      height: height,
      child: (Platform.isIOS || Platform.isAndroid) ? Shimmer.fromColors(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: baseColor,
        ),
        baseColor: baseColor,
        highlightColor: highlightColor,
      ) : Container(
        color: baseColor,
        width: width,
        height: height,
      ),
    );
  }
}

class ShimmerBuilder extends StatelessWidget {
  final double padding;
  final List<List<double>> rows;
  final double height;
  const ShimmerBuilder({
    this.padding = 0.0,
    this.rows = const [[double.infinity]],
    this.height = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final sizedShimmer = Padding(
      padding: EdgeInsets.only(right: 10),
      child: SizedShimmer(height: height),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding).copyWith(
        left: padding,
        right: max(padding - 10, 0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final columns in rows)
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (final width in columns)
                    if (width == double.infinity) Expanded(
                      child: sizedShimmer,
                    ) else SizedBox(
                      width: width,
                      child: sizedShimmer,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
