import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/dashboard_card_order.dart';
import 'package:mymgs/screens/dashboard/reorder.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/icon_button.dart';
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
          MGSIconButton(
            icon: PlatformIcons(context).settings,
            onPressed: _reorder,
            tooltip: 'Reorder dashboard',
            darkBackground: true,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ).copyWith(bottom: 30, top: 8),
        child: StreamBuilder<List<Widget?>>(
          stream: orderStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20),
                child: Spinner(),
              );
            }

            return Column(
              children: snapshot.data!.where((e) => e != null).toList() as List<Widget>,
            );
          },
        ),
      ),
    );
  }
}