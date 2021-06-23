import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data_classes/sportsday/feed_item.dart';
import 'package:mymgs/helpers/responsive.dart';

class MediaFeedTile extends StatefulWidget {
  final MediaFeedItem media;
  final Timestamp timestamp;

  const MediaFeedTile({
    required this.media,
    required this.timestamp,
  });

  _MediaFeedTileState createState() => _MediaFeedTileState();
}

class _MediaFeedTileState extends State<MediaFeedTile> with SingleTickerProviderStateMixin {
  late final AnimationController expandController;
  late final Animation<double> animation;

  bool expanded = false;

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.4,
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  void toggleExpansion() {
    setState(() {
      expanded = !expanded;
    });
    if (expanded) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleExpansion,
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.transparent, Colors.white],
          ).createShader(bounds);
        },
        blendMode: expanded ? BlendMode.dst : BlendMode.modulate,
        child: SizeTransition(
          axisAlignment: -1.0,
          sizeFactor: animation,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive(context).horizontalPadding,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Update from "
                      ),
                      TextSpan(
                        text: widget.media.author,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: " — " + Jiffy(widget.timestamp.toDate()).fromNow(),
                      )
                    ],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.media.text,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
