import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/catering.dart';
import 'package:mymgs/data_classes/catering_item.dart';
import 'package:mymgs/screens/catering/catering.dart';
import 'package:mymgs/screens/catering/catering_item.dart';
import 'package:mymgs/widgets/dashboard_cards/dashboard_card.dart';
import 'package:mymgs/widgets/spinner.dart';

class TodaysMenuCard extends StatelessWidget {
  final Key key;
  TodaysMenuCard(this.key);

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
    return FutureBuilder<CateringItem?>(
      future: cateringItemFuture,
      builder: (BuildContext context, snapshot) {
        List<Widget> children;
        VoidCallback? onPressed;

        final data = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          children = [
            Spinner(),
          ];
        } else if (data == null) {
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
              builder: (_) => CateringItemScreen(cateringItem: data),
            ));
          };

          children = [
            Text(
              data.menuItems.first.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '+ ${(data.menuItems.length - 1).toString()} more',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 5),
            _getViewTimetableButton(context),
          ];
        }

        return DashboardCard(
          title: 'Menu',
          titleMargin: 15,
          children: children,
          onPressed: onPressed,
        );
      }
    );
  }
}
