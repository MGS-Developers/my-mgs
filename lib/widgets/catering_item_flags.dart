import 'package:flutter/material.dart';

class CateringItemFlags extends StatelessWidget {
  final List<String> flags;
  const CateringItemFlags({
    @required this.flags,
  });

  Widget _buildFlag(String flag, BuildContext context) {
    String flagText = '';
    Color color = Theme.of(context).textTheme.bodyText2.color;

    switch(flag) {
      case 'v':
        // vegetarian
        flagText = 'V';
        color = Colors.green;
        break;
      case 'vg':
        // vegan
        flagText = 'Vg';
        color = Colors.green;
        break;
      case 'u':
        // kosher (OU-certified)
        flagText = 'Ⓤ';
        break;
      case 'h':
        // halal
        // be careful with this string!
        // it's an RTL unicode entity, so make sure it doesn't get displayed alongside regular LTR text
        flagText = 'حلال';
        break;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        flagText,
        style: TextStyle(
          color: color
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: flags.map((e) => _buildFlag(e, context)).toList(),
    );
  }
}