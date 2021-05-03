import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart';

class ArticleImageNode extends StatelessWidget {
  final ImageNode imageNode;
  final PublicationTheme theme;
  const ArticleImageNode({
    required this.imageNode,
    required this.theme,
  });

  void _viewImage(BuildContext context) {
    showBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: imageNode.value.url,
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            _viewImage(context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: imageNode.value.url,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          imageNode.value.alt,
          style: parsePbTextStyle(theme.paragraphStyle).copyWith(
            fontSize: 12,
            color: Theme.of(context).textTheme.bodyText1?.color,
          ),
        ),
        if (imageNode.value.hasSource()) Text(
          imageNode.value.source,
          style: parsePbTextStyle(theme.paragraphStyle).copyWith(
            fontSize: 12,
            color: Theme.of(context).textTheme.bodyText1?.color,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
