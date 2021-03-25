import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/safeguarding.dart';
import 'package:mymgs/data_classes/safeguarding_case.dart';
import 'package:mymgs/widgets/spinner.dart';

class MySafeguardingReports extends StatelessWidget {
  final _casesStream = getSafeguardingCases();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My cases"),
      ),
      body: StreamBuilder<List<SafeguardingCase>>(
        stream: _casesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Spinner(),
            );
          }

          final data = snapshot.data;
          if (data == null || data.length == 0) {
            return Center(
              child: Text(
                "No cases yet.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final _case = data[index];

              return ListTile(
                title: Text(
                  Jiffy(_case.createdAt.toDate()).yMMMEd,
                ),
              );
            }
          );
        },
      ),
    );
  }
}
