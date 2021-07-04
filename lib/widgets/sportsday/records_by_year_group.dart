import 'package:flutter/material.dart';
import 'package:mymgs/data/sportsday/records.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';
import 'package:mymgs/data_classes/sportsday/standing_record.dart';
import 'package:mymgs/widgets/spinner.dart';

class RecordsByYearGroup extends StatelessWidget {
  final int yearGroup;
  late final stream = getStandingRecordStream(yearGroup);
  RecordsByYearGroup({
    required this.yearGroup,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<StandingRecord>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong! Please try again in a few minutes"),
          );
        }

        final data = snapshot.data;
        if (data == null) {
          return Center(
            child: Spinner(),
          );
        }

        return SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text("Event")),
                DataColumn(label: Text("Standing holder")),
                DataColumn(label: Text("Standing record")),
                DataColumn(label: Text("Current holder")),
                DataColumn(label: Text("Current record")),
              ],
              rows: data.map((record) {
                final latestRecord = record.newRecord;
                final isBroken = (latestRecord?.value ?? 0) > record.value;

                return DataRow(
                  color: MaterialStateProperty.all(
                    isBroken == true ? Color(0xFFFDEC93): Colors.transparent,
                  ),
                  cells: [
                    DataCell(Text(record.eventGroup!.name)),
                    DataCell(Text(record.holder + " (${record.year})")),
                    DataCell(Text(record.value.toString() + (record.units == RecordUnits.meters ? 'm' : 's'))),
                    DataCell(Text(latestRecord == null ? '' : latestRecord.name)),
                    DataCell(Text(latestRecord == null ? '' : latestRecord.value.toString() + (record.units == RecordUnits.meters ? 'm' : 's')))
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
