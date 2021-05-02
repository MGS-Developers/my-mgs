import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart';
import 'package:mymgs/widgets/magazines/image_node.dart';
import 'package:mymgs/widgets/magazines/text_node.dart';

class ArticleNodeRenderer extends StatelessWidget {
  final PublicationTheme theme;
  final Node node;
  const ArticleNodeRenderer({
    Key? key,
    required this.theme,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      child: Builder(
        builder: (context) {
          if (node.hasText()) {
            return ArticleTextNode(richTextNode: node.text, theme: theme);
          } else if (node.hasImage()) {
            return ArticleImageNode(imageNode: node.image, theme: theme);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
