import 'package:flutter/material.dart' hide Form;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/sportsday/overview.dart';
import 'package:mymgs/screens/sportsday/form.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:mymgs/widgets/sportsday/form_position_table.dart';
import 'package:mymgs/widgets/sportsday/rank_highlight_row.dart';

class SportsDayDashboard extends StatefulWidget {
  const SportsDayDashboard();
  _SportsDayDashboardState createState() => _SportsDayDashboardState();
}

class _SportsDayDashboardState extends State<SportsDayDashboard> {
  late Stream<List<Form>> formStream;
  @override
  void initState() {
    formStream = getFormOverview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar("Sports Day 2021"),
      body: StreamBuilder<List<Form>>(
        stream: formStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Spinner(),
            );
          }

          final forms = snapshot.data;
          if (forms == null) {
            return Container();
          }

          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: FormPositionTable<Form>(
                data: forms,
                getForm: (e) => e,
                getFormName: (e) => e.humanID,
                getPoints: (e) => e.points.total,
                getPosition: (e) => e.points.schoolPosition,
              ),
            ),
          );
        },
      ),
    );
  }
}
