import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/safeguarding.dart';
import 'package:mymgs/data_classes/safeguarding_case.dart';
import 'package:mymgs/screens/wellbeing/reports/privacy.dart';
import 'package:mymgs/screens/wellbeing/reports/report_chat.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:mymgs/widgets/text_field.dart';

class MySafeguardingReports extends StatelessWidget {
  final _casesStream = getSafeguardingCases();

  Future<String?> _passphraseDialog(BuildContext context, String title, String caption, String action) async {
    final passphraseController = TextEditingController();

    final _dialogResponse = await showPlatformDialog<bool>(
      context: context,
      materialBarrierColor: Theme.of(context).shadowColor,
      barrierDismissible: true,
      builder: (context) => PlatformAlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(caption),
            const SizedBox(height: 15),
            MGSTextField(
              controller: passphraseController,
              obscureText: true,
            ),
          ],
        ),
        actions: [
          PlatformDialogAction(
            child: Text(action),
            onPressed: () {
              Navigator.pop<bool>(context, true);
            },
          )
        ],
      ),
    );

    if (_dialogResponse != true) {
      return null;
    } else {
      final passphrase = passphraseController.text;
      return passphrase;
    }
  }

  void _newCase(BuildContext context) async {
    final passphrase = await _passphraseDialog(
      context,
      "Open a case",
      "Please choose a unique passphrase for this case. You'll need it to access your messages. Passphrases cannot be recovered.",
      "Create",
    );

    if (passphrase == null) {
      return;
    }

    final _case = await createSafeguardingCase(passphrase);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SafeguardingReportChat(
        safeguardingCase: _case,
        passphrase: passphrase,
      ),
    ));
  }

  void _openCase(BuildContext context, SafeguardingCase _case) async {
    final passphrase = await _passphraseDialog(
      context,
      "Enter passphrase",
      "Please enter the passphrase you used when opening this case.",
      "Launch",
    );

    if (passphrase == null) {
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SafeguardingReportChat(
        safeguardingCase: _case,
        passphrase: passphrase,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My cases"),
        actions: [
          PlatformIconButton(
            icon: Icon(
              PlatformIcons(context).info,
              color: Colors.white,
            ),
            material: (_, __) => MaterialIconButtonData(
              tooltip: "About privacy"
            ),
            onPressed: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (_) => SafeguardingPrivacy(),
              ));
            }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Open case'),
        icon: Icon(Icons.add),
        onPressed: () {
          _newCase(context);
        },
      ),
      body: StreamBuilder<List<SafeguardingCase>>(
        stream: _casesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Spinner(),
            );
          }

          final data = snapshot.data;
          if (data == null || data.length == 0) {
            return Center(
              child: Text(
                "No cases yet.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final _case = data[index];

              return ListTile(
                title: Text(
                  "Opened ${Jiffy(_case.createdAt.toDate()).yMMMEdjm}",
                ),
                onTap: () {
                  _openCase(context, _case);
                },
              );
            }
          );
        },
      ),
    );
  }
}
