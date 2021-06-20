import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/helpers/app_metadata.dart';
import 'package:mymgs/screens/setup/confirm_email.dart';
import 'package:mymgs/screens/setup/intro.dart';
import 'package:mymgs/screens/setup/select_year_group.dart';
import 'package:mymgs/screens/setup/web.dart';

class SetupScreen extends StatefulWidget {
  final VoidCallback quitSetup;
  const SetupScreen({
    required this.quitSetup,
  });
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final PageController pageController = PageController();

  void _nextPage() {
    final currentPage = pageController.page;
    if (currentPage == null) return;

    pageController.animateToPage(
      currentPage.toInt() + 1,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to $appName!'),
      ),
      body: !kIsWeb ? PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Intro(
            onContinue: _nextPage,
            onComplete: widget.quitSetup,
          ),
          SelectYearGroup(onComplete: _nextPage),
          ConfirmEmail(onComplete: widget.quitSetup),
        ],
      ) : WebSetup(widget.quitSetup),
    );
  }
}