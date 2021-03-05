import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/screens/report_content.dart';

class InfoDisclaimer extends StatelessWidget {
  final double? hPadding;
  final Identifiable identifiable;
  const InfoDisclaimer({
    this.hPadding,
    required this.identifiable,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: hPadding != null ? EdgeInsets.symmetric(horizontal: hPadding!).copyWith(bottom: 20) : EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(platformPageRoute(
            context: context,
            builder: (_) => ReportContent(identifiable),
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'While we try our best to keep data on this app up-to-date, we can\'t guarantee its accuracy.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 5),
            Text(
              'Please tap here to report a problem with this item.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
