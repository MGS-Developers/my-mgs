import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/settings.dart';

typedef ToggleCallback = void Function(bool on);

class ToggleSetting extends StatefulWidget {
  final String name;
  final String tracker;
  final ToggleCallback callback;
  final String description;
  final bool enabled;
  final bool indented;

  // if false, the toggle is disabled and also set to false
  final bool requirement;

  const ToggleSetting({
    @required this.name,
    @required this.tracker,
    this.callback,
    this.description,
    this.enabled = true,
    this.requirement = true,
    this.indented = false,
  });

  _ToggleSettingState createState() => _ToggleSettingState();
}

class _ToggleSettingState extends State<ToggleSetting> {
  StreamController<bool> _streamController;

  @override
  void initState() {
    setState(() {
      _streamController = watchSetting<bool>(widget.tracker);
    });

    _streamController.stream.listen(widget.callback);

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ToggleSetting oldWidget) {
    if (widget.requirement == false && oldWidget.requirement != false) {
      _toggle(true);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _toggle(bool previousValue) async {
    await saveSetting(widget.tracker, !previousValue);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _streamController.stream,
      builder: (BuildContext context, snapshot) {
        final bool currentValue = snapshot.data ?? false;
        final bool canBeChanged = widget.enabled == true && widget.requirement == true;

        return ListTile(
          contentPadding: widget.indented ? const EdgeInsets.only(
            left: 40,
            right: 15,
          ) : null,
          enabled: canBeChanged,
          onTap: () {
            _toggle(currentValue);
          },
          title: Text(widget.name),
          subtitle: widget.description == null ? null : Text(widget.description),
          trailing: PlatformSwitch(
            value: currentValue,
            onChanged: canBeChanged ? (_) {
              _toggle(currentValue);
            } : null,
            activeColor: Theme.of(context).primaryColor,
          ),
        );
      }
    );
  }
}