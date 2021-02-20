import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/catering_item.dart';
import 'package:mymgs/data_classes/club_time.dart';
import 'package:mymgs/helpers/widget_helpers.dart';
import 'package:mymgs/widgets/catering_item_flags.dart';
import 'package:mymgs/widgets/info_disclaimer.dart';

class CateringItemScreen extends StatelessWidget {
  final CateringItem cateringItem;
  const CateringItemScreen({
    @required this.cateringItem,
  });

  Iterable<Widget> getMenuWidgets(BuildContext context) {
    return cateringItem.menuItems.map((e) {
      return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: getCardDecoration(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      e.name,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  if (e.flags != null && e.flags.isNotEmpty) ...[
                    const SizedBox(width: 5),
                    CateringItemFlags(flags: e.flags),
                  ]
                ],
              ),
              if (e.description != null) ...[
                const SizedBox(height: 2),
                Text(
                  e.description,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cateringItem.dayOfWeek.toDayString(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  text: '',
                  children: [
                    TextSpan(
                      text: 'Location: ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextSpan(
                      text: cateringItem.location,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ...getMenuWidgets(context),
              const SizedBox(height: 30),
              const InfoDisclaimer(),
            ],
          ),
        ),
      ),
    );
  }
}