import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/data_classes/shareable.dart';
import 'package:mymgs/helpers/app_metadata.dart';

class ShareButton extends StatelessWidget {
  final Shareable shareable;
  const ShareButton({
    required this.shareable,
  });

  void _share(BuildContext context) async {
    final shownBefore = await getSetting<bool?>('has-shown-share-alert');
    if (shownBefore != true) {
      await showPlatformDialog(
        context: context,
        materialBarrierColor: Theme.of(context).shadowColor,
        builder: (context) => PlatformAlertDialog(
          title: Text("Sharing on MyMGS"),
          content: Text(
            "When sharing content, please remember that only MGS students with the $appName app will be able to open your link."
          ),
          actions: [
            PlatformDialogAction(
              child: Text("Continue"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        )
      );

      await saveSetting('has-shown-share-alert', true);
    }

    final box = context.findRenderObject() as RenderBox;
    await shareable.share(box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      icon: Icon(
        PlatformIcons(context).share,
        color: Colors.white,
      ),
      onPressed: () {
        _share(context);
      },
      material: (_, __) => MaterialIconButtonData(
        tooltip: "Share",
      ),
    );
  }
}
