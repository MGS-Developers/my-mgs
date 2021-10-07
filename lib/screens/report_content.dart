import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/text_field.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ReportContent extends StatefulWidget {
  final Identifiable identifiable;
  const ReportContent(this.identifiable);
  _ReportContentState createState() => _ReportContentState();
}

class _ReportContentState extends State<ReportContent> {
  bool loading = false;
  late TextEditingController controller;

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
      materialBarrierColor: Theme.of(context).shadowColor,
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
    final ref = widget.identifiable.identify();

    return Scaffold(
      appBar: AppBar(
        title: Text("Report a content issue"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive(context).horizontalPadding, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "What's the problem with this item?",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 15),
              MGSTextField(
                controller: controller,
                maxLines: null,
                enabled: !loading,
                label: "Explain the issue...",
              ),
              const SizedBox(height: 15),
              Text(
                "Your report will be sent anonymously. Please don't include personal details.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 10),
              Text(
                "The following content identifier will be sent with your report: ${ref.path}",
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
