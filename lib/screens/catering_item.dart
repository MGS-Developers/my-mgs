import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/catering_item.dart';
import 'package:mymgs/data_classes/club_time.dart';
import 'package:mymgs/widgets/info_disclaimer.dart';

class CateringItemScreen extends StatelessWidget {
  final CateringItem cateringItem;
  const CateringItemScreen({
    @required this.cateringItem,
  });

  Iterable<Widget> getMenuWidgets(BuildContext context) {
    return cateringItem.menuItems.map((e) {
      return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Text(
              '‣',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                e,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 20,
                )
              ),
            ),
          ],
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
                    ]
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