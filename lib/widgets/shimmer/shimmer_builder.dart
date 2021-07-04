import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mymgs/widgets/shimmer/sized_shimmer.dart';

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
