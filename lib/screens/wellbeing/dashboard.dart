import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/safeguarding.dart';
import 'package:mymgs/data_classes/wellbeing_organisation.dart';
import 'package:mymgs/screens/wellbeing/report.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
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
                padding: EdgeInsets.only(top: 10, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confidential, anonymous reports',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'If you are concerned about your or someone else\'s mental wellbeing, you can use this tool to send an anonymous report.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 5),
                    MGSButton(
                      label: 'Make a report',
                      onPressed: () {
                        Navigator.of(context).push(platformPageRoute(
                          context: context,
                          builder: (_) => SafeguardingReport(),
                        ));
                      }
                    ),
                  ],
                ),
              ),

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
            ],
          );
        },
      ),
    );
  }
}
