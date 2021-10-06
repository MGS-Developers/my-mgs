import 'package:flutter/material.dart';
import 'package:mymgs/data/config.dart';
import 'package:mymgs/helpers/app_metadata.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/sportsday/quick_setup_card.dart';

class Intro extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onComplete;
  final isSignupEnabledFuture = Config.getIsSignupEnabled();
  final bool isAllowed;
  Intro({
    required this.onContinue,
    required this.onComplete,
    this.isAllowed = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive(context).centeredSetupPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SportsDayQuickSetupCard(onComplete: onComplete, autoInit: isAllowed != true),
          const SizedBox(height: 20),
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
                enabled: isAllowed == true,
                tooltip: isAllowed == true ? null : 'Currently unavailable',
                label: 'Continue',
                onPressed: onContinue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
