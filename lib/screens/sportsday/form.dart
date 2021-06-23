import 'package:flutter/material.dart' hide Form;
import 'package:mymgs/data/sportsday/form_events.dart';
import 'package:mymgs/data/sportsday/overview.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:mymgs/widgets/sportsday/form_score_tile.dart';
import 'package:mymgs/widgets/sportsday/statistic_container.dart';

class SportsDayForm extends StatelessWidget {
  final Form form;
  final Stream<FormWithPoints> formStream;
  final Stream<List<ScoreNode>> latestEventStream;
  SportsDayForm({
    required this.form,
  }) : formStream = getFormStream(form.id),
        latestEventStream = getLatestResults(form.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(form.humanID),
      ),
      body: StreamBuilder<FormWithPoints>(
        stream: formStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Spinner(),
            );
          }

          final data = snapshot.data;
          if (data == null) {
            return Center(
              child: Text("Something went wrong."),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatisticContainer(
                  rank: data.points.schoolPosition,
                  label: "School position",
                ),
                const SizedBox(height: 10),
                StatisticContainer(
                  rank: data.points.yearPosition,
                  label: "Year position",
                ),
                const SizedBox(height: 10),
                StatisticContainer(
                  label: "Total points",
                  value: data.points.total.toString(),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Latest results',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<ScoreNode>>(
                  stream: latestEventStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data == null) {
                      return Container();
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final node = data[index];
                        return FormScoreTile(scoreNode: node);
                      }
                    );
                  }
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
