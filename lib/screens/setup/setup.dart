import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/data/config.dart';
import 'package:mymgs/helpers/app_metadata.dart';
import 'package:mymgs/screens/setup/confirm_email.dart';
import 'package:mymgs/screens/setup/intro.dart';
import 'package:mymgs/screens/setup/select_year_group.dart';
import 'package:mymgs/screens/setup/web.dart';
import 'package:mymgs/widgets/spinner.dart';

class SetupScreen extends StatefulWidget {
  final VoidCallback quitSetup;
  const SetupScreen({
    required this.quitSetup,
  });
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final PageController pageController = PageController();
  final isSignupEnabled = Config.getIsSignupEnabled();

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
      body: FutureBuilder<bool>(
        future: isSignupEnabled,
        builder: (context, snapshot) {
          final isAllowed = snapshot.data;
          if (isAllowed == null) {
            return Center(
              child: Spinner(),
            );
          }

          if (kIsWeb) {
            return WebSetup(
              done: widget.quitSetup,
              isAllowed: isAllowed,
            );
          } else {
            return PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Intro(
                  onContinue: _nextPage,
                  onComplete: widget.quitSetup,
                  isAllowed: isAllowed,
                ),
                SelectYearGroup(onComplete: _nextPage),
                ConfirmEmail(onComplete: widget.quitSetup),
              ],
            );
          }
        }
      ),
    );
  }
}
