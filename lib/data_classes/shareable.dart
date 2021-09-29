import 'dart:ui';

import 'package:mymgs/data/sharing.dart';
import 'package:mymgs/helpers/deep_link.dart';

extension StringifyDLResource on DeepLinkResource {
  String toAnalyticsString() {
    return this.toString().split('.').last;
  }
}

mixin Shareable {
  late DeepLinkResource resource;
  late String id;

  Future<void> share([Rect? origin]) => shareShareable(this, origin);
}
