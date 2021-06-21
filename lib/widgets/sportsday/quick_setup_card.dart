import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/config.dart';
import 'package:mymgs/data/sportsday/temporary_authentication.dart';

class SportsDayQuickSetupCard extends StatelessWidget {
  final VoidCallback onComplete;
  SportsDayQuickSetupCard({
    Key? key,
    required this.onComplete,
  });

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
    Navigator.of(context).pop();
    onComplete();
  }

  @override
  Widget build(BuildContext context) {
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
