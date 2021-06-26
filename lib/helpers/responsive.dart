import 'package:flutter/widgets.dart';

class Responsive {
  final BuildContext context;
  Responsive(this.context);

  late final _screenSize = MediaQuery.of(context).size;

  bool get shouldSplitScreen {
    return _screenSize.width >= 768;
  }

  double get horizontalPadding {
    if (_screenSize.width > 450) {
      return _screenSize.width * 0.05;
    } else {
      return 15;
    }
  }

  double get horizontalListPadding {
    if (_screenSize.width > 450) {
      return _screenSize.width * 0.1;
    } else {
      return 0;
    }
  }

  double get horizontalReaderPadding {
    if (_screenSize.width > 450) {
      return _screenSize.width * 0.15;
    } else {
      return 20;
    }
  }

  EdgeInsets get horizontalCenteredSetupPadding {
    return EdgeInsets.symmetric(vertical: 30, horizontal: horizontalReaderPadding);
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

  double get imageWidth {
    if (_screenSize.width > 600) {
      return 350;
    } else {
      return double.infinity;
    }
  }
}
