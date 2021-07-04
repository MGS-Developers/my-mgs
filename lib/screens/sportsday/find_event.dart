import 'package:flutter/material.dart' hide Form;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/screens/sportsday/timetabled_event.dart';
import 'package:mymgs/widgets/button.dart';
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
          yearGroup: _form.yearGroup,
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
    final responsive = Responsive(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: responsive.horizontalPadding,
        ),
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
          controlsBuilder: (context, {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
            return Row(
              children: [
                MGSButton(
                  label: "Continue",
                  onPressed: onStepContinue,
                ),
              ],
            );
          },
          steps: [
            Step(
              title: const Text("Year group & form"),
              content: Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 10),
                child: FormSelect(
                  onChange: (_form) {
                    setState(() {
                      form = _form;
                    });
                  },
                ),
              ),
            ),
            Step(
              state: form == null ? StepState.disabled : StepState.indexed,
              title: const Text("Event"),
              content: Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 10),
                child: EventSelect(
                  selectedEventGroup: eventGroup,
                  onChange: (_eventGroup) {
                    setState(() {
                      eventGroup = _eventGroup;
                      subEvent = 0;
                    });
                  },
                ),
              ),
            ),
            Step(
              state: _selectedEventGroup == null ? StepState.disabled : StepState.indexed,
              title: const Text("Race"),
              content: _selectedEventGroup == null ? SizedBox() : Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 10),
                child: SubeventSelect(
                  eventGroup: _selectedEventGroup,
                  onChange: (_subEvent) {
                    setState(() {
                      subEvent = _subEvent;
                    });
                  },
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
