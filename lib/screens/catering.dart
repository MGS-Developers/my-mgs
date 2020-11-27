import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mymgs/data/catering.dart';
import 'package:mymgs/data_classes/catering_item.dart';
import 'package:mymgs/screens/catering_item.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:mymgs/data_classes/club_time.dart';

class Catering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catering'),
      ),
      body: FutureBuilder<List<CateringItem>>(
        future: getCateringItems(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Spinner(),
            );
          }

          if (snapshot.data == null || snapshot.data.isEmpty) {
            return const Center(
              child: Text(
                  'No catering items found.'
              ),
            );
          }

          return GroupedListView<CateringItem, int>(
            elements: snapshot.data,
            groupBy: (e) => e.week,
            groupSeparatorBuilder: (int value) => Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              child: Text(
                'Week $value',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
            useStickyGroupSeparators: true,
            itemBuilder: (context, item) {
              return ListTile(
                title: Text(
                    item.dayOfWeek.toDayString()
                ),
                subtitle: Text(
                  '${item.menuItems.first} + ${item.menuItems.length - 1} more',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: () {
                  Navigator.of(context).push(platformPageRoute(
                      context: context,
                      builder: (_) => CateringItemScreen(
                          cateringItem: item
                      )
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}