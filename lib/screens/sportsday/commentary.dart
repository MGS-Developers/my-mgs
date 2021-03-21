import 'package:flutter/material.dart';
import 'package:mymgs/data/sportsday/commentary_stream.dart';
import 'package:mymgs/widgets/spinner.dart';

class SportsDayCommentary extends StatelessWidget {
  final Stream<String?> stream;
  SportsDayCommentary() : stream = getCommentaryStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<String?>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Spinner(),
            );
          }

          final latestCaptionText = snapshot.data ?? "Captions will appear here...";
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Text(
              latestCaptionText,
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
