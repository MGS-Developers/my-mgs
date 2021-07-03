import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';

typedef _OnTapFunction = void Function(int index, [String? heroKey]);
typedef MasterBuilder = Widget Function(BuildContext context, int? selectedIndex, _OnTapFunction onTap);
typedef DetailBuilder = Widget Function(BuildContext context, int selectedIndex, bool isNewScreen, [String? heroKey]);

class MasterDetailScreen extends StatefulWidget {
  final MasterBuilder masterBuilder;
  final String masterTitle;
  final DetailBuilder detailBuilder;
  final double masterWidth;
  final bool useDrawerAppBar;
  const MasterDetailScreen({
    Key? key,
    required this.masterBuilder,
    required this.detailBuilder,
    this.masterTitle = '',
    this.masterWidth = 300,
    this.useDrawerAppBar = false,
  });

  _MasterDetailScreenState createState() => _MasterDetailScreenState();
}

class _MasterDetailScreenState extends State<MasterDetailScreen> {
  int? selectedIndex;

  void _onIndexTap(int index, [String? heroKey]) async {
    if (!Responsive(context).shouldSplitScreen) {
      Navigator.of(context).push(platformPageRoute(
        context: context,
        builder: (context) => widget.detailBuilder(context, index, true, heroKey),
      ));
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  Widget _buildMaster(BuildContext context) {
    final canBeSelected = Responsive(context).shouldSplitScreen;
    return widget.masterBuilder(context, canBeSelected ? selectedIndex : null, _onIndexTap);
  }

  Widget _buildDetail(BuildContext context) {
    final _index = selectedIndex;

    if (_index != null) {
      return widget.detailBuilder(context, _index, false);
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final shouldSplitScreen = Responsive(context).shouldSplitScreen;

    return Scaffold(
      appBar: widget.useDrawerAppBar ? DrawerAppBar(widget.masterTitle) : AppBar(
        title: Text(widget.masterTitle),
      ),
      body: Container(
        child: shouldSplitScreen ? Row(
          children: [
            Container(
              width: widget.masterWidth,
              child: Material(
                color: Theme.of(context).backgroundColor,
                child: _buildMaster(context)
              ),
            ),
            VerticalDivider(
              width: 10,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDetail(context),
            ),
          ],
        ) : _buildMaster(context),
      ),
    );
  }
}
