import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mymgs/data/dashboard_card_order.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/screens/dashboard/reorder.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/icon_button.dart';
import 'package:mymgs/widgets/spinner.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    required Key key,
  });
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
    final responsive = Responsive(context);

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
      body: StreamBuilder<List<Widget>>(
        stream: orderStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20),
              child: Spinner(),
            );
          }

          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.horizontalPadding,
            ).copyWith(top: 8, bottom: 30),
            crossAxisSpacing: 30,
            crossAxisCount: responsive.triColumnCount,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return data[index];
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          );
        },
      ),
    );
  }
}
