import 'dart:async';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

final _functions = FirebaseFunctions.instanceFor(region: 'europe-west2');
final _auth = FirebaseAuth.instance;

class WebAuthScreen extends StatefulWidget {
  const WebAuthScreen();
  _WebAuthScreenState createState() => _WebAuthScreenState();
}

class _WebAuthScreenState extends State<WebAuthScreen> {
  QRViewController? _controller;
  final _key = GlobalKey();

  bool loading = false;
  StreamSubscription? listener;

  void _watchBarcode() async {
    listener = _controller!.scannedDataStream.listen((event) async {
      if (loading) return;
      setState(() {
        loading = true;
      });

      final secret = event.code;

      final token = await _auth.currentUser!.getIdToken();
      final yearGroup = await getYearGroup();

      print(token);
      print(yearGroup);
      print("calling");
      final response = await _functions.httpsCallable('verifyQrCode').call({
        'token': token,
        'secret': secret,
        'yearGroup': yearGroup,
      });

      print("call complete");
      final verified = response.data["verified"] == true;
      if (verified) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }

  void _onQRViewCreated(QRViewController controller) async {
    try {
      _controller?.dispose();
    } catch (e) {}
    try {
      listener?.cancel();
    } catch (e) {}

    _controller = controller;
    _watchBarcode();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller?.pauseCamera();
    } else if (Platform.isIOS) {
      _controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyMGS Web"),
      ),
      body: loading ? Center(
        child: Spinner(),
      ) : QRView(
        key: _key,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderRadius: 20,
        ),
      ),
    );
  }
}
