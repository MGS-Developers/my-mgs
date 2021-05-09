import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mymgs/data/catering.dart';
import 'package:mymgs/data_classes/catering_item.dart';
import 'package:mymgs/screens/catering/catering_item.dart';
import 'package:mymgs/widgets/grouped_list_separator.dart';
import 'package:mymgs/widgets/master_detail.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:mymgs/data_classes/club_time.dart';

class Catering extends StatelessWidget {
  final cateringItemsFuture = getCateringItems();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CateringItem>>(
      future: cateringItemsFuture,
      builder: (context, snapshot) {
        final data = snapshot.data;

        return MasterDetailScreen(
          masterTitle: "Catering",
          masterBuilder: (context, index, onTap) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Spinner(),
              );
            }

            if (data == null || data.isEmpty) {
              return const Center(
                child: Text(
                  'No catering items found.',
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
                final itemIndex = data.indexOf(item);

                return ListTile(
                  title: Text(
                    item.dayOfWeek.toDayString(),
                  ),
                  subtitle: Text(
                    '${item.menuItems.first.name} + ${item.menuItems.length - 1} more',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () => onTap(itemIndex),
                  tileColor: index == itemIndex ? Theme.of(context).primaryColorDark : null,
                );
              },
            );
          },
          detailBuilder: (context, index, isNewScreen, [_]) {
            if (data == null) return SizedBox();
            return CateringItemScreen(cateringItem: data[index], showAppBar: isNewScreen);
          }
        );
      }
    );
  }
}
