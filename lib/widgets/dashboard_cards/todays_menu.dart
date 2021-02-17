import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/catering.dart';
import 'package:mymgs/data_classes/catering_item.dart';
import 'package:mymgs/screens/catering.dart';
import 'package:mymgs/screens/catering_item.dart';
import 'package:mymgs/widgets/dashboard_cards/dashboard_card.dart';
import 'package:mymgs/widgets/spinner.dart';

class TodaysMenu extends StatelessWidget {
  TodaysMenu();

  final cateringItemFuture = getTodaysMenu();

  Widget _getViewTimetableButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(platformPageRoute(
          context: context,
          builder: (_) => Catering(),
        ));
      },
      child: const Text('View timetable'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CateringItem>(
      future: cateringItemFuture,
      builder: (BuildContext context, snapshot) {
        List<Widget> children;
        VoidCallback onPressed;

        if (snapshot.connectionState == ConnectionState.waiting) {
          children = [
            Spinner(),
          ];
        } else if (!snapshot.hasData) {
          children = [
            Text(
              'It looks like today isn\'t a school day.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 5),
            _getViewTimetableButton(context),
          ];
        } else {
          onPressed = () {
            Navigator.of(context).push(platformPageRoute(
              context: context,
              builder: (_) => CateringItemScreen(cateringItem: snapshot.data),
            ));
          };

          children = [
            Text(
              snapshot.data.menuItems.first.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              '+ ${(snapshot.data.menuItems.length - 1).toString()} more',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 5),
            _getViewTimetableButton(context),
          ];
        }

        return DashboardCard(
          title: 'Today\'s menu',
          titleMargin: 15,
          children: children,
          onPressed: onPressed,
        );
      }
    );
  }
}