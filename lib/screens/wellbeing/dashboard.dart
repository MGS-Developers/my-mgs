import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/safeguarding.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/data_classes/wellbeing_organisation.dart';
import 'package:mymgs/screens/wellbeing/info.dart';
import 'package:mymgs/screens/wellbeing/report.dart';
import 'package:mymgs/screens/wellbeing/reports/my_reports.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/info_disclaimer.dart';
import 'package:mymgs/widgets/wellbeing/resource_card.dart';
import 'package:mymgs/widgets/spinner.dart';

class WellbeingDashboard extends StatefulWidget {
  const WellbeingDashboard();
  _WellbeingDashboardState createState() => _WellbeingDashboardState();
}

class _WellbeingDashboardState extends State<WellbeingDashboard> {
  final organisationsFuture = getWellbeingOrganisations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar("Wellbeing"),
      body: FutureBuilder<List<WellbeingOrganisation>>(
        future: organisationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Spinner(),
            );
          }

          final data = snapshot.data;
          if (data == null || snapshot.data?.length == 0) {
            return Container();
          }

          return ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Report a safeguarding issue',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pulvinar blandit tortor, sed condimentum arcu sollicitudin sit amet.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 5),
                    MGSButton(
                      label: 'Open reporting menu',
                      onPressed: () {
                        Navigator.of(context).push(platformPageRoute(
                          context: context,
                          builder: (_) => MySafeguardingReports(),
                        ));
                      }
                    ),
                  ],
                ),
              ),

              ListTile(
                title: Text("I need help!"),
                subtitle: Text("Find out who to get help from at MGS"),
                leading: Icon(
                  Icons.info_outlined,
                  size: 32,
                ),
                onTap: () {
                  Navigator.of(context).push(platformPageRoute(
                    context: context,
                    builder: (_) => WellbeingInfo(),
                  ));
                },
              ),

              const SizedBox(height: 15),
              GridView.count(
                shrinkWrap: true,
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: data.map((organisation) => WellbeingResourceCard(
                  organisation: organisation,
                )).toList(),
              ),

              const SizedBox(height: 20),
              InfoDisclaimer(identifiable: customIdentifiable('wellbeing')),
            ],
          );
        },
      ),
    );
  }
}
