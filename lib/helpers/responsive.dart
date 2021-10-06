import 'package:flutter/widgets.dart';

class Responsive {
  final BuildContext context;
  Responsive(this.context);

  late final _screenSize = MediaQuery.of(context).size;

  bool get shouldSplitScreen {
    return _screenSize.width >= 768;
  }

  // For standard pages with simple text-based or interactive content
  double get horizontalPadding {
    if (_screenSize.width > 450) {
      return _screenSize.width * 0.05;
    } else {
      return 15;
    }
  }

  // For ListView widgets to horizontally pad lists
  double get horizontalListPadding {
    if (_screenSize.width > 450) {
      return _screenSize.width * 0.1;
    } else {
      return 0;
    }
  }

  // For ListTile widgets to horizontally pad contents when the parent ListView has no padding
  double get horizontalListTilePadding {
    if (_screenSize.width > 450) {
      return _screenSize.width * 0.1;
    } else {
      return 16;
    }
  }

  // For pages containing primarily textual content intended for batch-reading (e.g. News/Magazine)
  double get horizontalReaderPadding {
    if (_screenSize.width > 450) {
      return _screenSize.width * 0.15;
    } else {
      return 20;
    }
  }

  // For pages containing a single action in the center of the screen (e.g. the Setup process)
  EdgeInsets get centeredSetupPadding {
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
