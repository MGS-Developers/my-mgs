import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart' hide TextStyle;
import 'package:mymgs/widgets/magazines/scroll_prompt.dart';

class EditionCover extends StatefulWidget {
  final Edition edition;
  final PublicationTheme theme;
  final String publicationTitle;
  const EditionCover({
    required this.edition,
    required this.theme,
    required this.publicationTitle,
  });
  _EditionCoverState createState() => _EditionCoverState();
}

class _EditionCoverState extends State<EditionCover> with TickerProviderStateMixin {
  late final _introController = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
    value: 0,
  );
  late final Animation<double> _zoomAnimation = Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
    parent: _introController,
    curve: Curves.easeOut,
  ));

  late final _contentAnimation = CurvedAnimation(
    parent: _introController,
    curve: Interval(
      0.3, 0.6,
      curve: Curves.easeInOut,
    ),
  );
  late final Animation<double> _darkenAnimation = Tween(begin: 0.0, end: 0.4).animate(_contentAnimation);
  late final Animation<double> _textOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_contentAnimation);
  late final Animation<Offset> _textMovementAnimation = Tween(begin: Offset(0, 0.05), end: Offset(0, 0)).animate(_contentAnimation);

  @override
  void initState() {
    super.initState();
    _introController.animateTo(1);
  }

  @override
  void dispose() {
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: Stack(
        children: [
          Positioned.fill(
            child: ScaleTransition(
              scale: _zoomAnimation,
              child: CachedNetworkImage(
                imageUrl: widget.edition.coverImage.url,
                fit: BoxFit.cover,
              ),
            )
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned.fill(
            child: FadeTransition(
              opacity: _darkenAnimation,
              child: Container(color: Colors.black),
            ),
          ),
          Positioned.fill(
            child: SlideTransition(
              position: _textMovementAnimation,
              child: FadeTransition(
                opacity: _textOpacityAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.publicationTitle,
                      style: parsePbTextStyle(widget.theme.titleStyle).copyWith(
                        fontSize: 34,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.edition.title,
                      style: parsePbTextStyle(widget.theme.headingStyle).copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ScrollPrompt(theme: widget.theme),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
