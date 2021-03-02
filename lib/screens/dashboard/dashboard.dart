import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/dashboard_card_order.dart';
import 'package:mymgs/screens/dashboard/reorder.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';
import 'package:mymgs/widgets/spinner.dart';

class Dashboard extends StatefulWidget {
  const Dashboard();
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final orderStream = getOrderedCards();

  void _reorder() {
    Navigator.of(context).push(platformPageRoute(
      context: context,
      builder: (_) => ReorderDashboard(),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar(
        'Dashboard',
        actions: [
          PlatformIconButton(
            icon: Icon(PlatformIcons(context).settings),
            onPressed: _reorder,
            material: (_, __) => MaterialIconButtonData(
              tooltip: "Reorder",
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15
        ).copyWith(bottom: 10),
        child: StreamBuilder<List<Widget>>(
          stream: orderStream,
          builder: (context, snapshot) {
            print(snapshot.error);
            print((snapshot.error as Error)?.stackTrace);

            if (!snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20),
                child: Spinner(),
              );
            }

            return Column(
              children: snapshot.data,
            );
          },
        ),
      ),
    );
  }
}