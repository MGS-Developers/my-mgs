import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/clubs.dart';
import 'package:mymgs/data/events.dart';
import 'package:mymgs/data/news.dart';
import 'package:mymgs/screens/catering/catering.dart';
import 'package:mymgs/screens/clubs/club.dart';
import 'package:mymgs/screens/events/event_screen.dart';
import 'package:mymgs/screens/news/news_item.dart';
import 'package:mymgs/screens/wellbeing/report.dart';
// uni_links doesn't have a null safety version available yet
// ignore: import_of_legacy_library_into_null_safe
import 'package:uni_links/uni_links.dart';

final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

enum DeepLinkStatus {
  Determining,
  NoLink,
  YesLink,
}

enum DeepLinkResource {
  newsItem,
  catering,
  club,
  event,
  wellbeing,
}

class DeepLink {
  // an item from DeepLinkResource
  DeepLinkResource resource;
  String id;

  DeepLink(this.resource, this.id);

  String toPayloadString() {
    return resource.index.toString() + "-" + id;
  }
  static DeepLink? fromPayloadString(String payloadString) {
    if (!payloadString.contains("-")) return null;

    final splitString = payloadString.split("-");
    final resource = DeepLinkResource.values[int.parse(splitString[0])];
    final id = splitString[1];

    return DeepLink(resource, id);
  }

  Future<PageRoute> getRoute(BuildContext context) async {
    Widget? page;

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
      case DeepLinkResource.club:
        final club = await getClub(id);
        if (club == null) break;

        page = ClubScreen(club: club);
        break;
      case DeepLinkResource.event:
        final event = await getEvent(id);
        if (event == null) break;

        page = EventScreen(event: event);
        break;
      case DeepLinkResource.wellbeing:
        if (id == 'report') {
          page = SafeguardingReport();
        }
        break;
    }

    return platformPageRoute(
      context: context,
      builder: (_) => page!,
    );
  }
}

Future<DeepLink?> _getFLNLink() async {
  final response = await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (response == null) {
    return null;
  }

  final payload = response.payload;
  if (!response.didNotificationLaunchApp || payload == null) {
    return null;
  }

  return DeepLink.fromPayloadString(payload);
}

DeepLink? _nativeUriToDeepLink(Uri? nativeUri) {
  if (nativeUri == null) return null;
  if (nativeUri.scheme != "mymgs") return null;

  return DeepLink.fromPayloadString(nativeUri.host);
}

Future<DeepLink?> _getNativeLink() async {
  try {
    final response = await getInitialUri();
    return _nativeUriToDeepLink(response);
  } on PlatformException {
    return null;
  }
}

final _linkController = StreamController<DeepLink?>();
var _lock = false;
StreamController<DeepLink?> getLinkController() {
  return _linkController;
}

/// Can only be called once in the app's lifecycle.
/// Trying to call [watchDeepLink] more than once will result in an exception.
StreamController<DeepLink?> watchDeepLink() {
  if (_lock == true) {
    throw Exception("watchDeepLink has already been called.");
  }
  _lock = true;

  bool empty = true;

  _getFLNLink()
  .then((value) {
    if (value != null) {
      empty = false;
      _linkController.add(value);
    }
  });
  
  _getNativeLink()
  .then((value) {
    if (value != null) {
      empty = false;
      _linkController.add(value);
    }
  });

  final nativeUriListener = getUriLinksStream().listen((event) {
    _linkController.add(_nativeUriToDeepLink(event));
  });
  _linkController.onCancel = () {
    nativeUriListener.cancel();
  };

  if (empty) {
    _linkController.add(null);
  }
  return _linkController;
}
