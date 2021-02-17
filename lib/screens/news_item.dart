import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mymgs/data_classes/news.dart';
import 'package:mymgs/widgets/news/news_appbar.dart';

class NewsItemScreen extends StatefulWidget {
  final NewsItem newsItem;
  const NewsItemScreen({
    @required this.newsItem,
    Key key,
  });

  _NewsItemScreenState createState() => _NewsItemScreenState();
}

class _NewsItemScreenState extends State<NewsItemScreen> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NewsAppBar(controller: _controller),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            Material(
              elevation: 3,
              child: Container(
                height: 300,
                width: double.infinity,
                child: Stack(
                  children: [
                    Image(
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.newsItem.image.fullUrl),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [
                            0.0,
                            0.6,
                            1.0,
                          ],
                          colors: [
                            Color(0x90000000),
                            Colors.transparent,
                            Color(0x90000000),
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
                        widget.newsItem.headline,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: MarkdownBody(
                data: widget.newsItem.body,
                styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      fontSize: 17,
                      fontFamily: "Newsreader",
                      fontWeight: FontWeight.normal,
                      height: 1.2,
                    )
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}