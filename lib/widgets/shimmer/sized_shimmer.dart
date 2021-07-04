import 'package:flutter/foundation.dart';
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
      child: !kIsWeb ? Shimmer.fromColors(
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
