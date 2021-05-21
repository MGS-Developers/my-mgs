import 'package:flutter/material.dart' hide Form;
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/widgets/sportsday/event_select.dart';
import 'package:mymgs/widgets/sportsday/form_select.dart';
import 'package:mymgs/widgets/sportsday/subevent_select.dart';

class SportsdayFindEvent extends StatefulWidget {
  const SportsdayFindEvent();
  _SportsdayFindEventState createState() => _SportsdayFindEventState();
}

class _SportsdayFindEventState extends State<SportsdayFindEvent> {
  int step = 0;
  Form? form;
  EventGroup? eventGroup;

  @override
  Widget build(BuildContext context) {

    final _selectedEventGroup = eventGroup;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Stepper(
          currentStep: step,
          onStepCancel: () {
            if (step == 0) return;
            setState(() {
              step -= 1;
            });
          },
          onStepContinue: () {
            if (step > 2) return;
            setState(() {
              step += 1;
            });
          },
          onStepTapped: (index) {
            setState(() {
              step = index;
            });
          },
          steps: [
            Step(
              title: const Text("Year group & form"),
              content: FormSelect(
                onChange: (_form) {
                  setState(() {
                    form = _form;
                  });
                },
              ),
            ),
            Step(
              title: const Text("Event"),
              content: EventSelect(
                selectedEventGroup: eventGroup,
                onChange: (_eventGroup) {
                  setState(() {
                    eventGroup = _eventGroup;
                  });
                },
              ),
            ),
            Step(
              state: _selectedEventGroup == null ? StepState.disabled : StepState.indexed,
              title: const Text("Race"),
              content: _selectedEventGroup == null ? SizedBox() : SubeventSelect(eventGroup: _selectedEventGroup),
            ),
          ]
        ),
      ),
    );
  }
}
