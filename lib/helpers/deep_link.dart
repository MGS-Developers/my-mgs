import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/news.dart';
import 'package:mymgs/screens/catering.dart';
import 'package:mymgs/screens/news/news_item.dart';

final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

enum DeepLinkStatus {
  Determining,
  NoLink,
  YesLink,
}

enum DeepLinkResource {
  newsItem,
  catering,
}

class DeepLink {
  // an item from DeepLinkResource
  DeepLinkResource resource;
  String id;

  DeepLink(this.resource, this.id);

  String toPayloadString() {
    return resource.index.toString() + "-" + id;
  }
  factory DeepLink.fromPayloadString(String payloadString) {
    if (!payloadString.contains("-")) return null;

    final splitString = payloadString.split("-");
    final resource = DeepLinkResource.values[int.parse(splitString[0])];
    final id = splitString[1];

    return DeepLink(resource, id);
  }

  Future<PageRoute> getRoute(BuildContext context) async {
    Widget page;

    switch(resource) {
      case DeepLinkResource.newsItem:
        final newsItem = await getNewsItem(id);
        if (newsItem == null) break;

        page = NewsItemScreen(
          newsItem: newsItem,
        );
        break;
      case DeepLinkResource.catering:
        page = Catering();
        break;
    }

    return platformPageRoute(
      context: context,
      builder: (_) => page,
    );
  }
}

Future<DeepLink> _getFLNLink() async {
  final response = await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (!response.didNotificationLaunchApp || response.payload == null) {
    return null;
  }

  return DeepLink.fromPayloadString(response.payload);
}

final _linkController = StreamController<DeepLink>();
StreamController<DeepLink> getLinkController() {
  return _linkController;
}

/// Can only be called once in the app's lifecycle
StreamController<DeepLink> watchDeepLink() {
  bool empty = true;

  _getFLNLink()
  .then((value) {
    if (value != null) {
      empty = false;
      _linkController.add(value);
    }
  });

  if (empty) {
    _linkController.add(null);
  }
  return _linkController;
}
