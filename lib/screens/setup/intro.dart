import 'package:flutter/material.dart';
import 'package:mymgs/helpers/app_metadata.dart';
import 'package:mymgs/widgets/button.dart';

class Intro extends StatelessWidget {
  final VoidCallback onContinue;
  const Intro({
    required this.onContinue,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Confirm your email to start',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 10),
          Text(
            'Select your year group, confirm your @mgs.org email, and start using $appName!',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 10),
          ButtonBar(
            children: [
              MGSButton(
                label: 'Begin!',
                onPressed: onContinue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}