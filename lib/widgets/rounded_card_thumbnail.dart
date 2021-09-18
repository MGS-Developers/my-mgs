import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/image.dart';
import 'package:mymgs/widgets/nullable_image.dart';

class RoundedCardThumbnail extends StatelessWidget {
  final MGSImage? image;
  const RoundedCardThumbnail({
    Key? key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final image = this.image;
    if (image == null) {
      return SizedBox();
    }

    final url = image.thumbnailUrl;
    if (url == null || url == '') {
      return SizedBox();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: NullableImage(
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        image: image,
      ),
    );
  }
}
