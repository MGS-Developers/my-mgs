import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanCode extends StatefulWidget {
  final VoidCallback onComplete;
  const ScanCode({
    @required this.onComplete,
  });

  _ScanCodeState createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  final GlobalKey _qr = GlobalKey(debugLabel: 'qr-code-reader-key');
  QRViewController controller;
  bool verifyingCode = false;
  Timer failureTimer;

  void _setupRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(days: 1));
    await remoteConfig.activateFetched();
  }

  @override
  void initState() {
    super.initState();
    _setupRemoteConfig();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
    failureTimer?.cancel();
  }

  Future<void> _tryCode(String codeData) async {
    if (verifyingCode) return;

    setState(() {
      verifyingCode = true;
    });
    if(await processQR(codeData)) {
      widget.onComplete();
      setState(() {
        verifyingCode = false;
      });
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: const Text('That code didn\'t work! Try again.'),
        duration: const Duration(seconds: 1),
      ));

      failureTimer = Timer(const Duration(milliseconds: 500), () {
        setState(() {
          verifyingCode = false;
        });
      });
    }
  }

  void _onQREvent(Barcode barcode) async {
    await _tryCode(barcode.code);
  }

  void _mountQRView(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(_onQREvent);
  }

  void _manualEntry() {
    final codeController = TextEditingController();
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: const Text("Enter code manually"),
        content: PlatformTextField(
          controller: codeController,
          textInputAction: TextInputAction.go,
        ),
        actions: [PlatformDialogAction(
          child: const Text('Submit!'),
          onPressed: () async {
            Navigator.of(context).pop();
            await _tryCode(codeController.text);
          },
        )],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: verifyingCode ? Center(
        child: Spinner(),
      ) : Stack(
        children: [
          Expanded(
            child: QRView(
              key: _qr,
              onQRViewCreated: _mountQRView,
              overlay: QrScannerOverlayShape(
                borderRadius: 15,
              ),
            ),
          ),
          Positioned.fill(
            top: null,
            bottom: 40,
            child: Align(
              alignment: Alignment.center,
              child: MGSButton(
                label: "Enter code",
                onPressed: _manualEntry,
              ),
            ),
          ),
        ],
      ),
    );
  }
}