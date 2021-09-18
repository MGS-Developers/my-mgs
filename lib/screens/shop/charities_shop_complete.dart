import 'package:flutter/material.dart';
import 'package:mymgs/helpers/responsive.dart';

class CharitiesShopComplete extends StatelessWidget {
  final String userCode;
  const CharitiesShopComplete({
    required this.userCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order complete!"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive(context).horizontalReaderPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Order complete!",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Please pick your order up from our collection point at XYZ within 5 school days. We're open before school and at lunch.",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              "Write this code down somewhere and bring it with you to collect your order:",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              userCode,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}