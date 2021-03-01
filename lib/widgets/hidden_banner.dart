import 'package:flutter/material.dart';

class HiddenBanner extends StatefulWidget {
  final String title;
  final Widget body;

  const HiddenBanner({
    @required this.title,
    @required this.body,
    Key key,
  });

  _HiddenBannerState createState() => _HiddenBannerState();
}

class _HiddenBannerState extends State<HiddenBanner> {
  bool _expanded = false;

  void _expansionCallback(int index, bool expanded) {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: _expansionCallback,
      children: [
        ExpansionPanel(
          isExpanded: _expanded,
          canTapOnHeader: true,
          body: Padding(
            padding: EdgeInsets.all(10),
            child: widget.body,
          ),
          headerBuilder: (_, __) {
            return ListTile(
              title: Text(
                widget.title,
              ),
            );
          }
        ),
      ],
    );
  }
}