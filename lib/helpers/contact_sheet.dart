import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

void showContactSheet(BuildContext context, String? name, String? email) {
  showPlatformModalSheet(
    context: context,
    material: MaterialModalSheetData(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
    ),
    builder: (_) => Container(
      height: 180,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20).copyWith(
        bottom: MediaQuery.of(context).padding.bottom,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (name != null) Text(
            name,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 5),
          if (email != null) Text(
            email,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 10),
          if (email != null) ButtonBar(
            children: [
              MGSButton(
                label: "Send email",
                onPressed: () {
                  launch("mailto:$email");
                },
              ),
              MGSButton(
                label: "Copy email",
                outlined: true,
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: email));
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Copied to clipboard!"),
                    duration: const Duration(seconds: 1),
                  ));
                },
              )
            ],
          ),
        ],
      ),
    ),
  );
}
