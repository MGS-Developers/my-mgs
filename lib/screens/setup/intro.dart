import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Intro extends StatelessWidget {
  final VoidCallback onContinue;
  const Intro({
    @required this.onContinue,
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
            'Scan a QR code to start',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 10),
          Text(
            'Your form tutor will show you a barcode — tap \'Begin!\', select your year group, and scan it!',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 5),
          Text(
            'When prompted, make sure you enable camera permissions to use the QR code scanner.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 10),
          PlatformButton(
            child: const Text('Begin!'),
            onPressed: onContinue,
          )
        ],
      ),
    );
  }
}