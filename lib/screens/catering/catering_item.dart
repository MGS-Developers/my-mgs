import 'package:flutter/material.dart';
import 'package:mymgs/data/analytics.dart';
import 'package:mymgs/data_classes/catering_item.dart';
import 'package:mymgs/data_classes/club_time.dart';
import 'package:mymgs/helpers/widget_helpers.dart';
import 'package:mymgs/widgets/catering_item_flags.dart';
import 'package:mymgs/widgets/info_disclaimer.dart';

class CateringItemScreen extends StatefulWidget {
  final CateringItem cateringItem;
  final bool showAppBar;
  const CateringItemScreen({
    required this.cateringItem,
    this.showAppBar = true,
  });

  _CateringItemScreenState createState() => _CateringItemScreenState();
}

class _CateringItemScreenState extends State<CateringItemScreen> {
  @override
  void initState() {
    super.initState();
    AnalyticsEvents.view(
      widget.cateringItem,
      "Food " + widget.cateringItem.dayOfWeek.toDayString() + " Week " + widget.cateringItem.week.toString(),
    );
  }

  Iterable<Widget> getMenuWidgets(BuildContext context) {
    return widget.cateringItem.menuItems.map((e) {
      final flags = e.flags;
      final description = e.description;

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
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  if (flags != null && flags.isNotEmpty) ...[
                    const SizedBox(width: 5),
                    CateringItemFlags(flags: flags),
                  ]
                ],
              ),
              if (description != null) ...[
                const SizedBox(height: 2),
                Text(
                  description,
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
    final cateringItem = widget.cateringItem;
    return Scaffold(
      appBar: widget.showAppBar ? AppBar(
        title: Text(
          cateringItem.dayOfWeek.toDayString(),
        ),
      ) : null,
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
              InfoDisclaimer(identifiable: cateringItem),
            ],
          ),
        ),
      ),
    );
  }
}