import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';
import 'package:mymgs/data_classes/sportsday/standing_record.dart';
import 'package:mymgs/widgets/spinner.dart';

class RecordsByYearGroup extends StatelessWidget {
  final Future<List<MergedRecord>> mergedRecordFuture;
  RecordsByYearGroup({
    required this.mergedRecordFuture,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MergedRecord>>(
      future: mergedRecordFuture,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return Center(
            child: Spinner(),
          );
        }

        return SingleChildScrollView(
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
              final latestRecord = record.latestRecord;

              return DataRow(
                color: MaterialStateProperty.all(
                  latestRecord?.isNewRecord == true ? Color(0xFFFDEC93): Colors.transparent,
                ),
                cells: [
                  DataCell(Text(record.standingRecord.eventGroup!.name)),
                  DataCell(Text(record.standingRecord.holder + " (${record.standingRecord.year})")),
                  DataCell(Text(record.standingRecord.value.toString() + (record.standingRecord.units == RecordUnits.meters ? 'm' : 's'))),
                  DataCell(Text(latestRecord == null ? '' : latestRecord.competitorName)),
                  DataCell(Text(latestRecord == null ? '' : latestRecord.value.toString() + (latestRecord.units == RecordUnits.meters ? 'm' : 's')))
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
