import 'package:flutter/material.dart';

class InfoDisclaimer extends StatelessWidget {
  const InfoDisclaimer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'While we try our best to keep data on this app up-to-date, we can\'t guarantee its accuracy.',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 5),
        Text(
          'Please contact the MGS School Council if you find anything that needs fixing.',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}