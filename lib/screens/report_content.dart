import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/widgets/button.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ReportContent extends StatefulWidget {
  final Identifiable identifiable;
  const ReportContent(this.identifiable);
  _ReportContentState createState() => _ReportContentState();
}

class _ReportContentState extends State<ReportContent> {
  bool loading = false;
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  Future<void> _send() async {
    setState(() {
      loading = true;
    });

    await _firestore
        .collection('content_reports')
        .add({
      "identifier": widget.identifiable.identify(),
      "message": controller.text,
      "createdAt": FieldValue.serverTimestamp(),
    });

    setState(() {
      loading = false;
    });
    showPlatformDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PlatformAlertDialog(
        title: Text("Message sent!"),
        actions: [PlatformDialogAction(
          child: Text("Go back"),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        )],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report a content issue"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What's the problem with this item?",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              PlatformTextField(
                controller: controller,
                maxLines: null,
                enabled: !loading,
                material: (_, __) => MaterialTextFieldData(
                  decoration: InputDecoration(
                    labelText: "Explain the issue...",
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Your report will be sent anonymously. Please don't include personal details.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 15),
              Builder(
                builder: (context) => MGSButton(
                  label: "Send",
                  enabled: !loading,
                  onPressed: _send,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}