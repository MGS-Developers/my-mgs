import 'package:flutter/material.dart';
import 'package:mymgs/screens/setup/intro.dart';
import 'package:mymgs/screens/setup/scan_code.dart';
import 'package:mymgs/screens/setup/select_year_group.dart';

class SetupScreen extends StatefulWidget {
  final VoidCallback quitSetup;
  const SetupScreen({
    @required this.quitSetup,
  });
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final PageController pageController = PageController();

  void _nextPage() {
    pageController?.animateToPage(
      pageController.page.toInt() + 1,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to MyMGS!'),
      ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Intro(
            onContinue: _nextPage,
          ),
          SelectYearGroup(onComplete: _nextPage),
          ScanCode(onComplete: widget.quitSetup),
        ],
      ),
    );
  }
}