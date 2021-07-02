import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class TileTimer extends StatefulWidget {
  final Timestamp time;
  const TileTimer({
    required this.time,
  });
  _TileTimerState createState() => _TileTimerState();
}

class _TileTimerState extends State<TileTimer> {
  late final Timer _timer;
  late String timeText;

  void _setTimeText() {
    setState(() {
      timeText = Jiffy(widget.time.toDate()).fromNow();
    });
  }

  @override
  void initState() {
    super.initState();
    _setTimeText();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => _setTimeText());
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timeText,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
