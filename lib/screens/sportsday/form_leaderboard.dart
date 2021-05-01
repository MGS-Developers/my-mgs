import 'package:flutter/material.dart' hide Form;
import 'package:mymgs/data/sportsday/overview.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:mymgs/widgets/sportsday/form_position_table.dart';

class SportsDayForms extends StatefulWidget {
  const SportsDayForms();
  _SportsDayFormsState createState() => _SportsDayFormsState();
}

class _SportsDayFormsState extends State<SportsDayForms> {
  late Stream<List<Form>> formStream;
  @override
  void initState() {
    formStream = getFormOverview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
