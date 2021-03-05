import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:mymgs/data_classes/wellbeing_organisation.dart';
import 'package:mymgs/widgets/tappable_card.dart';
import 'package:url_launcher/url_launcher.dart';

Color _parseColor(String input) {
  return Color(int.parse(input.substring(1, 7), radix: 16) + 0xFF000000);
}

bool _isNullish(String? input) {
  return input == null || input == '';
}

class WellbeingResourceCard extends StatelessWidget {
  final WellbeingOrganisation organisation;
  const WellbeingResourceCard({
    required this.organisation,
  });

  void _launchUrl() {
    if (!_isNullish(organisation.url)) {
      FlutterWebBrowser.openWebPage(
        url: organisation.url,
        customTabsOptions: CustomTabsOptions(
          toolbarColor: _parseColor(organisation.color),
        ),
      );
    }
  }

  void _launchPhone() {
    if (!_isNullish(organisation.phoneNumber)) {
      launch("tel:${organisation.phoneNumber}");
    }
  }

  void _launchAction(BuildContext context) {
    if (!_isNullish(organisation.url) && !_isNullish(organisation.phoneNumber)) {
      showPlatformDialog(
        context: context,
        materialBarrierColor: Theme.of(context).shadowColor,
        builder: (_) => SimpleDialog(
          title: Text("Contact ${organisation.name}"),
          children: [
            SimpleDialogOption(
              child: Text("Call ${organisation.phoneNumber}"),
              onPressed: _launchPhone,
            ),
            SimpleDialogOption(
              child: Text("Visit ${organisation.url}"),
              onPressed: _launchUrl,
            )
          ],
        )
      );
      return;
    }

    _launchUrl();
    _launchPhone();
  }

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(organisation.color);
    final hslColor = HSLColor.fromColor(color);
    final textColor = color.computeLuminance() > 0.4 ? Colors.black : Colors.white;
    final captionColor = color.computeLuminance() > 0.4 ?
        hslColor.withLightness(hslColor.lightness - 0.15) :
        hslColor.withLightness(hslColor.lightness + 0.3);

    return TappableCard(
      color: color,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      onPressed: () => _launchAction(context),
      children: [
        Text(
          organisation.name,
          textAlign: TextAlign.left,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 22,
          ),
        ),
        Text(
          organisation.caption,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: captionColor.toColor(),
          ),
        )
      ],
    );
  }
}