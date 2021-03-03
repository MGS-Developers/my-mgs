import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/safeguarding.dart';
import 'package:mymgs/keys.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/hidden_banner.dart';
import 'package:mymgs/widgets/spinner.dart';

class SafeguardingReport extends StatefulWidget {
  const SafeguardingReport();
  _SafeguardingReportState createState() => _SafeguardingReportState();
}

class _SafeguardingReportState extends State<SafeguardingReport> {
  TextEditingController _input;
  bool _canSubmit = false;
  bool _loading = false;

  void _updateCanSubmit() {
    setState(() {
      _canSubmit = _input.text.length > 0;
    });
  }

  @override
  void initState() {
    _input = TextEditingController();
    _input.addListener(_updateCanSubmit);
    super.initState();
  }

  @override
  void dispose() {
    _input.removeListener(_updateCanSubmit);
    _input.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _loading = true;
    });
    await encryptAndSubmitReport(_input.text);
    setState(() {
      _loading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report a concern"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "Your report will be sent with end-to-end encryption. Only authorised safeguarding staff can see what you enter.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 15),
            PlatformTextField(
              controller: _input,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 8,
              enabled: !_loading,
            ),
            const SizedBox(height: 15),
            MGSButton(
              label: "Submit",
              onPressed: _canSubmit && !_loading ? _submit : null,
            ),
            if (_loading) Spinner(),
            const SizedBox(height: 20),
            HiddenBanner(
              title: "🔒 Security info",
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Public key",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SelectableText(
                    getSafeguardingPGP(),
                    style: TextStyle(
                      fontFamily: "monospace",
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Key type",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SelectableText(getSafeguardingKeyType()),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}