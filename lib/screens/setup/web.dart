import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:mymgs/widgets/sportsday/quick_setup_card.dart';
import 'package:qr_flutter/qr_flutter.dart';

final _functions = FirebaseFunctions.instanceFor(region: 'europe-west2');
final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

enum SetupStage {
  FetchingSecret,
  Waiting,
  FetchingToken,
}

class WebSetup extends StatefulWidget {
  final VoidCallback done;
  final bool isAllowed;
  const WebSetup({
    required this.done,
    this.isAllowed = false,
  });
  _WebSetupState createState() => _WebSetupState();
}

class _WebSetupState extends State<WebSetup> {
  SetupStage stage = SetupStage.FetchingSecret;

  String? sessionId;
  String? sessionSecret;

  StreamSubscription? documentWatcher;

  void _fetchCode() async {
    final response = await _functions.httpsCallable('getQrCodeData')();
    sessionId = response.data["sessionId"];
    sessionSecret = response.data["sessionSecret"];

    setState(() {
      stage = SetupStage.Waiting;
    });
    _watchDoc();
  }

  void _watchDoc() {
    documentWatcher = _firestore.collection('web_auth_sessions').doc(sessionId).snapshots().listen((event) {
      final data = event.data();
      if (data == null || data["ready"] == false) return;

      setState(() {
        stage = SetupStage.FetchingToken;
      });
      _fetchToken();
    });
  }

  void _fetchToken() async {
    final response = await _functions.httpsCallable('retrieveSignInToken')({
      'sessionId': sessionId,
      'sessionSecret': sessionSecret,
    });
    final token = response.data["token"];
    final yearGroup = response.data["yearGroup"];

    if (!(token is String) || !(yearGroup is num)) {
      await showPlatformDialog(
        context: context,
        materialBarrierColor: Theme.of(context).shadowColor,
        barrierDismissible: true,
        builder: (context) {
          return PlatformAlertDialog(
            title: Text("Something went wrong"),
          );
        }
      );

      setState(() {
        stage = SetupStage.FetchingSecret;
      });
      _fetchCode();
    }

    await saveSetting('year-group', yearGroup);
    await _auth.signInWithCustomToken(token);

    widget.done();
  }

  @override
  void initState() {
    super.initState();
    _fetchCode();
  }

  @override
  void dispose() {
    documentWatcher?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: Responsive(context).horizontalPadding),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Builder(
            builder: (context) {
              if (stage != SetupStage.Waiting) {
                return Spinner();
              }

              final _secret = sessionSecret;
              if (_secret == null) return SizedBox();

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SportsDayQuickSetupCard(onComplete: widget.done, autoInit: !widget.isAllowed),
                  if (widget.isAllowed) QrImage(
                    data: _secret,
                    size: MediaQuery.of(context).size.height * 0.5,
                  ),
                  if (widget.isAllowed) const SizedBox(height: 20),
                  if (widget.isAllowed) Text(
                    "Open MyMGS on your phone to sign in...",
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
