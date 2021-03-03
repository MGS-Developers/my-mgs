import 'package:flutter/material.dart';
import 'package:mymgs/helpers/widget_helpers.dart';
import 'package:mymgs/widgets/tappable_card.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final double titleMargin;
  final VoidCallback onPressed;
  const DashboardCard({
    @required this.title,
    @required this.children,
    this.titleMargin,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: TappableCard(
        onPressed: onPressed,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: titleMargin ?? 5),
          ...children,
        ],
      )
    );
  }
}