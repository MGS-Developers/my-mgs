import 'dart:ui';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:mymgs/data/analytics.dart';
import 'package:mymgs/data_classes/shareable.dart';
import 'package:mymgs/helpers/deep_link.dart';
import 'package:share/share.dart';

Future<void> shareShareable(Shareable shareable, [Rect? origin]) async {
  await AnalyticsEvents.share(shareable);

  final deepLink = DeepLink(shareable.resource, shareable.id);
  final parameters = DynamicLinkParameters(
    uriPrefix: "https://mymgs.link",
    link: Uri.parse("https://deep.mymgs.link/" + deepLink.toPayloadString()),
    androidParameters: AndroidParameters(
      packageName: "org.mgs.my",
    ),
    iosParameters: IosParameters(
      bundleId: "org.mgs.my.ios",
    ),
    dynamicLinkParametersOptions: DynamicLinkParametersOptions(
      shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
    ),
  );

  final link = await parameters.buildShortLink();
  await Share.share(
    link.shortUrl.toString(),
    sharePositionOrigin: origin
  );
}
