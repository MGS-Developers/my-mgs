import 'package:flutter/material.dart';
import 'package:mymgs/helpers/widget_helpers.dart';

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
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: Ink(
        padding: EdgeInsets.all(15),
        decoration: getCardDecoration(context, borderRadius: 20),
        child: Column(
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
        ),
      ),
    );
  }
}