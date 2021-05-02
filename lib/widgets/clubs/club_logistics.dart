import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/helpers/contact_sheet.dart';
import 'package:mymgs/widgets/text_icon.dart';

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

    showContactSheet(context, staffName, staffEmail);
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