import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/button.dart';

class ConfirmEmail extends StatefulWidget {
  final VoidCallback onComplete;
  const ConfirmEmail({
    required this.onComplete,
  });

  _ConfirmEmailState createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  String? emailError;
  String? sessionId;
  late TextEditingController email;
  late TextEditingController code;
  bool loading = false;

  @override
  void initState() {
    email = TextEditingController();
    code = TextEditingController();
    super.initState();
  }

  void _send() async {
    if (!email.text.trim().endsWith('@mgs.org')) {
      setState(() {
        emailError = "Please use an email address ending with @mgs.org";
      });
      return;
    }

    setState(() {
      loading = true;
      emailError = null;
    });

    try {
      final _sessionId = await sendEmail(email.text);
      if (_sessionId == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("That doesn't look like a valid email address!"),
        ));
      } else {
        setState(() {
          sessionId = _sessionId;
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Something went wrong! Please try again later."),
      ));
    }

    setState(() {
      loading = false;
    });
  }

  void _confirm() async {
    setState(() {
      loading = true;
    });
    try {
      await confirmCode(code.text, sessionId!);
      widget.onComplete();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("That code is incorrect! Please try again."),
      ));
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive(context).horizontalCenteredSetupPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sessionId == null ? [
          Text(
            'Confirm your MGS email',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 10),
          Text(
            'We won\'t store this for more than a few milliseconds, and your app activity will always stay anonymous.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 15),
          PlatformTextField(
            controller: email,
            enabled: !loading,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => _send(),
            material: (_, __) => MaterialTextFieldData(
              decoration: InputDecoration(
                labelText: "Email address (@mgs.org)",
                errorText: emailError,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ButtonBar(
            children: [
              MGSButton(
                label: "Send!",
                onPressed: _send,
                enabled: !loading,
              ),
            ],
          ),
        ] : [
          const Image(
            image: AssetImage('assets/confirmation_sent.png'),
            height: 70,
          ),
          const SizedBox(height: 20),
          Text(
            'Enter your verification code',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 10),
          Text(
            'We sent you a 6-digit verification code; please enter it here.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 15),
          PlatformTextField(
            controller: code,
            keyboardType: TextInputType.number,
            enabled: !loading,
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '######',
              ),
            ],
            onSubmitted: (_) => _confirm(),
          ),
          const SizedBox(height: 10),
          ButtonBar(
            children: [
              MGSButton(
                label: "Change email",
                enabled: !loading,
                onPressed: () {
                  setState(() {
                    sessionId = null;
                  });
                },
                outlined: true,
              ),
              MGSButton(
                label: "Confirm!",
                enabled: !loading,
                onPressed: _confirm,
              ),
            ]
          ),
        ],
      ),
    );
  }
}