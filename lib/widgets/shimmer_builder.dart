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
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFFE0E0E0),
        ),
        baseColor: Color(0xFFE0E0E0),
        highlightColor: Color(0xFFBABABA),
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
