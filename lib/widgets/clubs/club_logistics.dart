import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/text_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubLogistics extends StatelessWidget {
  final Club club;
  final bool showFullTime;
  final bool interactiveStaffName;
  final bool showLocation;
  const ClubLogistics({
    required this.club,
    this.showFullTime = false,
    this.interactiveStaffName = false,
    this.showLocation = false,
  });

  void _showStaffDetails(BuildContext context) {
    final staffName = club.staffName;
    final staffEmail = club.staffEmail;

    showPlatformModalSheet(
      context: context,
      material: MaterialModalSheetData(
        backgroundColor: Colors.transparent,
        isDismissible: true,
        enableDrag: true,
      ),
      builder: (_) => Container(
        height: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20).copyWith(
          bottom: MediaQuery.of(context).padding.bottom,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (staffName != null) Text(
              staffName,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 5),
            if (staffEmail != null) Text(
              staffEmail,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 10),
            if (staffEmail != null) ButtonBar(
              children: [
                MGSButton(
                  label: "Send email",
                  onPressed: () {
                    launch("mailto:$staffEmail");
                  },
                ),
                MGSButton(
                  label: "Copy email",
                  outlined: true,
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: staffEmail));
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Copied to clipboard!"),
                      duration: const Duration(seconds: 1),
                    ));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final staffName = club.staffName;
    final location = club.location;

    return Column(
      children: [
        Row(
          children: [
            TextIcon(icon: PlatformIcons(context).time),
            const SizedBox(width: 5),
            Text(
              showFullTime ? club.time.toDisplayString() : club.time.getDisplayTime(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        if (staffName != null) InkWell(
          onTap: interactiveStaffName ? () {
            _showStaffDetails(context);
          } : null,
          child: Row(
            children: [
              TextIcon(icon: PlatformIcons(context).person),
              const SizedBox(width: 5),
              Text(
                staffName,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        if (showLocation && location != null) Row(
          children: [
            TextIcon(icon: PlatformIcons(context).location),
            const SizedBox(width: 5),
            Text(
              location,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ],
    );
  }
}