import 'package:flutter/material.dart' hide Form;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/screens/sportsday/timetabled_event.dart';
import 'package:mymgs/widgets/sportsday/event_select.dart';
import 'package:mymgs/widgets/sportsday/form_select.dart';
import 'package:mymgs/widgets/sportsday/subevent_select.dart';

class SportsDayFindEvent extends StatefulWidget {
  const SportsDayFindEvent();
  _SportsDayFindEventState createState() => _SportsDayFindEventState();
}

class _SportsDayFindEventState extends State<SportsDayFindEvent> {
  int step = 0;
  Form? form;
  EventGroup? eventGroup;
  int? subEvent;

  void _nextStep() {
    if (step == 2) {
      final _form = form;
      final _eventGroup = eventGroup;
      final _subEvent = subEvent;

      if (_form == null || _eventGroup == null || _subEvent == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please complete all fields."),
        ));
        return;
      }

      Navigator.of(context).push(platformPageRoute(
        context: context,
        builder: (_) => SportsDayTimetabledEvent(
          eventGroup: _eventGroup,
          subEvent: _subEvent,
          form: _form,
        ),
      ));
    } else {
      setState(() {
        step += 1;
      });
    }
  }

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
          onStepContinue: _nextStep,
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
              content: _selectedEventGroup == null ? SizedBox() : SubeventSelect(
                eventGroup: _selectedEventGroup,
                onChange: (_subEvent) {
                  setState(() {
                    subEvent = _subEvent;
                  });
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}
