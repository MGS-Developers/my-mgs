import 'package:flutter/widgets.dart';

class Responsive {
  final BuildContext context;
  Responsive(this.context);

  late final _screenSize = MediaQuery.of(context).size;

  double get horizontalPadding {
    if (_screenSize.width > 450) {
      return _screenSize.width * 0.05;
    } else {
      return 15;
    }
  }

  double get horizontalReaderPadding {
    if (_screenSize.width > 450) {
      return _screenSize.width * 0.1;
    } else {
      return 20;
    }
  }

  int get triColumnCount {
    if (_screenSize.width > 1024) {
      return 3;
    } else if (_screenSize.width >= 650) {
      return 2;
    } else {
      return 1;
    }
  }
}
