import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/data/setup.dart';
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

  void _onQREvent(Barcode barcode) async {
    if (verifyingCode) return;

    setState(() {
      verifyingCode = true;
    });
    if(await processQR(barcode.code)) {
      widget.onComplete();
      setState(() {
        verifyingCode = false;
      });
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: const Text('That QR code didn\'t work! Try again.'),
        duration: const Duration(seconds: 1),
      ));

      failureTimer = Timer(const Duration(milliseconds: 500), () {
        setState(() {
          verifyingCode = false;
        });
      });
    }
  }

  void _mountQRView(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(_onQREvent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: verifyingCode ? Center(
        child: Spinner(),
      ) : QRView(
        key: _qr,
        onQRViewCreated: _mountQRView,
        overlay: QrScannerOverlayShape(
          borderRadius: 15,
        ),
      ),
    );
  }
}