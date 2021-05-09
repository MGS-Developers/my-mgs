import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/shareable.dart';
import 'package:mymgs/widgets/share_button.dart';

const heroHeight = 300.0;
class ImageScaffold extends StatefulWidget {
  final List<Widget> children;
  final String appBarLabel;
  final ImageProvider? image;
  final String title;
  final String? heroKey;
  final Shareable? shareable;
  final TextStyle? titleStyle;
  final bool showAppBar;

  const ImageScaffold({
    required this.children,
    required this.title,
    required this.appBarLabel,
    this.image,
    this.heroKey,
    this.shareable,
    this.titleStyle,
    this.showAppBar = true,
  });
  _ImageScaffoldState createState() => _ImageScaffoldState();
}

class _ImageScaffoldState extends State<ImageScaffold> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildHeader(BuildContext context) {
    final image = widget.image;

    return Material(
      elevation: 3,
      child: Container(
        height: heroHeight,
        width: double.infinity,
        child: Stack(
          children: [
            if (image != null) Image(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              image: image,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0x60000000),
                    Colors.transparent,
                    Color(0x80000000),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ).copyWith(bottom: 15),
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.title,
                style: widget.titleStyle ?? TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _shareable = widget.shareable;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            title: widget.showAppBar ? Text(widget.appBarLabel) : null,
            automaticallyImplyLeading: widget.showAppBar,
            pinned: true,
            stretch: true,
            expandedHeight: heroHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: widget.heroKey != null ? Hero(
                tag: widget.heroKey ?? '',
                transitionOnUserGestures: true,
                child: _buildHeader(context),
              ) : _buildHeader(context),
            ),
            actions: _shareable != null ? [
              ShareButton(shareable: _shareable)
            ] : null,
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                ...widget.children,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
