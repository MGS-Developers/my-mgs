import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/config.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data/sportsday/temporary_authentication.dart';
import 'package:mymgs/widgets/spinner.dart';

class SportsDayQuickSetupCard extends StatefulWidget {
  final VoidCallback onComplete;
  final bool autoInit;
  const SportsDayQuickSetupCard({
    Key? key,
    required this.onComplete,
    this.autoInit = false,
  });

  _SportsDayQuickSetupCardState createState() => _SportsDayQuickSetupCardState();
}

class _SportsDayQuickSetupCardState extends State<SportsDayQuickSetupCard> {
  final isSeasonStream = Config.getIsSportsDaySeason();
  void _setup(BuildContext context) async {
    showPlatformDialog(
      context: context,
      barrierDismissible: false,
      materialBarrierColor: Theme.of(context).shadowColor,
      builder: (context) => PlatformAlertDialog(
        title: Text("Please wait"),
        content: Text("One moment while we configure MyMGS..."),
      ),
    );
    await authenticateSportsDay();
    await setupAnalytics();
    Navigator.of(context).pop();
    widget.onComplete();
  }

  bool autoInitComplete = false;
  void _setupIfSeason() async {
    final isSeason = await isSeasonStream.last;
    if (isSeason) {
      _setup(context);
    }

    setState(() {
      autoInitComplete = true;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.autoInit) {
      _setupIfSeason();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.autoInit && !autoInitComplete) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Spinner(),
      );
    }

    if (autoInitComplete) {
      return SizedBox();
    }

    return StreamBuilder<bool>(
      stream: isSeasonStream,
      builder: (context, snapshot) {
        var shouldShowCard = false;
        final data = snapshot.data;
        if (data != null) {
          shouldShowCard = data;
        }

        if (shouldShowCard) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                child: Material(
                  color: Theme.of(context).primaryColor,
                  child: InkWell(
                    onTap: () {
                      _setup(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sports Day",
                            style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Tap here to view real-time Sports Day 2021 data without signing in. Available for both competitors & spectators.",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Divider(),
            ],
          );
        } else {
          return SizedBox();
        }
      }
    );
  }
}
