import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mymgs/data/catering.dart';
import 'package:mymgs/data_classes/catering_item.dart';
import 'package:mymgs/screens/catering/catering_item.dart';
import 'package:mymgs/widgets/grouped_list_separator.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:mymgs/data_classes/club_time.dart';

class Catering extends StatelessWidget {
  final cateringItemsFuture = getCateringItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catering'),
      ),
      body: FutureBuilder<List<CateringItem>>(
        future: cateringItemsFuture,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Spinner(),
            );
          }

          final data = snapshot.data;
          if (data == null || data.isEmpty) {
            return const Center(
              child: Text(
                'No catering items found.'
              ),
            );
          }

          return GroupedListView<CateringItem, int>(
            elements: data,
            groupBy: (e) => e.week,
            groupSeparatorBuilder: (int value) => GroupedListSeparator(
              label: 'Week $value',
              contrastBackground: true,
            ),
            useStickyGroupSeparators: true,
            itemBuilder: (context, item) {
              return ListTile(
                title: Text(
                    item.dayOfWeek.toDayString()
                ),
                subtitle: Text(
                  '${item.menuItems.first.name} + ${item.menuItems.length - 1} more',
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