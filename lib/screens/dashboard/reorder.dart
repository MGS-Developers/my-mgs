import 'package:flutter/material.dart';
import 'package:mymgs/data/dashboard_card_order.dart';

class ReorderDashboard extends StatefulWidget {
  _ReorderDashboardState createState() => _ReorderDashboardState();
}

class _ReorderDashboardState extends State<ReorderDashboard> {
  List order = [];

  @override
  void initState() {
    getOrderedNames().then((value) {
      setState(() {
        order = [...(value ?? defaultOrder)];
      });
    });
    super.initState();
  }

  void _reorder(int oldIndex, int newIndex, BuildContext context) async {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final name = order.removeAt(oldIndex);
      order.insert(newIndex, name);
    });

    await setOrder(order);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Order saved!"),
      duration: const Duration(seconds: 1),
    ));
  }

  String _getDisplayName(String name) {
    return name[0].toUpperCase() + name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reorder dashboard"),
      ),
      body: Builder(
        builder: (context) => ReorderableListView(
          onReorder: (o, i) {
            _reorder(o, i, context);
          },
          children: [
            for (final name in order)
              ListTile(
                title: Text(_getDisplayName(name)),
                key: Key(name),
                trailing: Icon(Icons.reorder),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Tap and hold to reorder!"),
                    duration: const Duration(seconds: 1),
                  ));
                },
              ),
          ],
        ),
      ),
    );
  }
}
